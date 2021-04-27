//
//  SignUpViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import domain

class StatusViewModel: ObservableObject {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

public class SignupViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    @Published var confirmPassword: String = ""
    @Published var isHidden = true
    
    @Published var statusViewModel: StatusViewModel = StatusViewModel(title: "")
    
    @Published var isErrorAlert: Bool = false
    @Published var isNotInternet: Bool = false
    @Published var isSuccessAlert: Bool = false
    @Published var emailErrorMsg: String = ""
    @Published var passwordErrorMsg: String = ""
    @Published var confirmIsError: Bool = false
    @Published var confirmErrorMsg: String = ""
    @Published var enableSignUp: Bool = false
    
    private var bag = Set<AnyCancellable>()
    
    private var loginInteractor: LoginInteractorInterface
    private var authDataRepo: AuthDomainRepoInterface
    
    public init(loginInteractor: LoginInteractorInterface, authDataRepo: AuthDomainRepoInterface) {
        self.loginInteractor = loginInteractor
        self.authDataRepo = authDataRepo
        bindInputs()
        bindOutputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    enum Input {
        case registerTapped
    }
    
    private let registerSubject = PassthroughSubject<Void, Never>()
    private let responseSubject = PassthroughSubject<Bool, Never>()
    private let errorSubject = PassthroughSubject<GEError, Never>()
    
    func bindInputs() {
        registerSubject
            .flatMap { [loginInteractor] _ in
                loginInteractor.register(email: self.id, password: self.password, name: self.nickname)
                    .map { [weak self] _ in
                        UDManager.shared.email = self?.id
                        UDManager.shared.password = self?.password
                        return true }
                    .catch { [weak self] error -> Empty<Bool, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
                    .flatMap { [loginInteractor] _ in
                        loginInteractor.login(email: self.id, password: self.password)
                            .map { [weak self] token in
                                UDManager.shared.token = token.accessToken
                                self?.authDataRepo.getStudent()
                                return true }
                            .catch { [weak self] error -> Empty<Bool, Never> in
                                self?.errorSubject.send(error)
                                return .init()
                            }
                    }
            }.share()
            .subscribe(responseSubject)
            .store(in: &bag)
    }
    
    func apply(_ input: Input) {
        switch input {
        case .registerTapped:
            registerSubject.send(())
            UDManager.shared.email = self.id
            UDManager.shared.password = self.password
        }
    }
    
    private var emailValidPublisher: AnyPublisher<EmailValidation, Never> {
        $id
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { email in
                if email.isEmpty {
                    return .emptyEmail
                } else if !email.isValidEmail() {
                    return .inValidEmail
                } else {
                    return .validEmail
                }
        }
        .eraseToAnyPublisher()
    }
    
    private var passwordValidPublisher: AnyPublisher<PasswordValidation, Never> {
        $password
            .removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { password in
                if password.isEmpty {
                    return .empty
                } else {
                    return passwordStrengthChecker(forPassword: password)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var confirmPasswordValidPublisher: AnyPublisher<PasswordValidation, Never> {
        $confirmPassword
            .debounce(for: 0.0, scheduler: RunLoop.main)
            .map { confirmPassword in
                if confirmPassword.isEmpty {
                    return .confirmPasswordEmpty
                } else if self.password != confirmPassword {
                    return .notMatch
                } else {
                    return .reasonable
                }
            }
            .eraseToAnyPublisher()
    }
    
    func bindOutputs() {
        Publishers.CombineLatest3(self.emailValidPublisher,
                                  self.passwordValidPublisher,
                                 self.confirmPasswordValidPublisher)
            .dropFirst()
            .sink {_emailError, _passwordValidator, _confirmPasswordValidator in
                
                self.enableSignUp =
                    _emailError.errorMessage == nil &&
                    _passwordValidator.errorMessage == nil &&
                    _confirmPasswordValidator.confirmPasswordErrorMessage == nil
            }
            .store(in: &bag)
        
        emailValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { (_emailError) in
                self.emailErrorMsg = _emailError.errorMessage ?? ""
        }
        .store(in: &bag)
        
        passwordValidPublisher
            .dropFirst()
            .sink { (_passwordValidator) in
                self.passwordErrorMsg = _passwordValidator.errorMessage ?? ""
            }
            .store(in: &bag)
        
        confirmPasswordValidPublisher
            .dropFirst()
            .sink { (_confirmPasswordValidator) in
                self.confirmErrorMsg = _confirmPasswordValidator.confirmPasswordErrorMessage ?? ""
            }
            .store(in: &bag)
        
        confirmPasswordValidPublisher
            .dropFirst()
            .sink { (_confirmPasswordValidator) in
                self.confirmIsError = _confirmPasswordValidator.confirmPasswordErrorMessage != nil
            }
            .store(in: &bag)
        
        responseSubject
            .assign(to: \.isSuccessAlert, on: self)
            .store(in: &bag)
        
        errorSubject
            .map { error  in
                if error != GEError.noInternet {
                    return true
                } else { return false }}
            .assign(to: \.isErrorAlert, on: self)
            .store(in: &bag)
        
        errorSubject
            .map { error in
                if error == GEError.noInternet {
                    return true
                } else { return false } }
            .assign(to: \.isNotInternet, on: self)
            .store(in: &bag)
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword(pattern: String = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$") -> Bool {
        let passwordRegex = pattern
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
