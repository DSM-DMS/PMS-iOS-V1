//
//  LoginViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Combine
import domain

public class LoginViewModel: ObservableObject {
    @Published var id = ""
    @Published var password = ""
    @Published var isHidden = true
    @Published var errorMsg = ""
    @Published var isNotMatchError = false
    @Published var isNotInternet = false
    @Published var isSuccessAlert = false
    @Published var isEnable = false
    
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
        case loginTapped
        case anonymous
    }
    
    private let loginSubject = PassthroughSubject<Void, Never>()
    private let anonymousSubject = PassthroughSubject<Void, Never>()
    private let responseSubject = PassthroughSubject<Bool, Never>()
    private let errorSubject = PassthroughSubject<GEError, Never>()
    
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
    
    func apply(_ input: Input) {
        switch input {
        case .loginTapped:
            loginSubject.send(())
        case .anonymous:
            anonymousSubject.send(())
        }
    }
    
    func bindInputs() {
        loginSubject
            .flatMap { [loginInteractor] _ in
                loginInteractor.login(email: self.id, password: self.password)
                    .map { [weak self] token in
                        UDManager.shared.email = self?.id
                        UDManager.shared.password = self?.password
                        UDManager.shared.token = token.accessToken
                        self?.authDataRepo.getStudent()
                        return true }
                    .catch { [weak self] error -> Empty<Bool, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(responseSubject)
            .store(in: &bag)
        
        anonymousSubject
            .flatMap { [loginInteractor] token in
                loginInteractor.login(email: "test@test.com", password: "testpass")
                    .map { token in
                        UDManager.shared.token = token.accessToken
                        return true }
                    .catch { [weak self] error -> Empty<Bool, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(responseSubject)
            .store(in: &bag)
        
    }
    
    func bindOutputs() {
        
        //        Publishers.(self.emailValidPublisher,
        //                                  self.passwordValidPublisher,
        //                                 self.confirmPasswordValidPublisher)
        //            .dropFirst()
        //            .sink {_emailError, _passwordValidator, _confirmPasswordValidator in
        //
        //                self.enableSignUp =
        //                    _emailError.errorMessage == nil &&
        //                    _passwordValidator.errorMessage == nil &&
        //                    _confirmPasswordValidator.confirmPasswordErrorMessage == nil
        //            }
        //            .store(in: &bag)
        
        emailValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { (_emailError) in
                self.errorMsg = _emailError.errorMessage ?? ""
            }
            .store(in: &bag)
        
        emailValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map { error in
                if error == .validEmail { return true } else { return false }
            }
            .assign(to: \.isEnable, on: self)
            .store(in: &bag)
        
        responseSubject
            .assign(to: \.isSuccessAlert, on: self)
            .store(in: &bag)
        
        errorSubject
            .map { error  in
                if error != GEError.noInternet {
                    return true
                } else { return false }}
            .assign(to: \.isNotMatchError, on: self)
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
