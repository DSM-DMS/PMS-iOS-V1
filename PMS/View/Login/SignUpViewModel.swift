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

class StatusViewModel: ObservableObject {
    var title: String

    init(title: String) {
        self.title = title
    }
}

class SignupViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    @Published var confirmPassword: String = ""
    @Published var isHidden = true

    @Published var statusViewModel: StatusViewModel = StatusViewModel(title: "")

    @Published var isErrorAlert: Bool = false
    @Published var passwordError: String? = ""
    @Published var confirmIsError: Bool = false
    @Published var confirmErrorMsg: String = ""
    @Published var enableSignUp: Bool = false
    
    private var apiManager: APIManager
    private var bag = Set<AnyCancellable>()
    
    enum Input {
        case registerTapped
    }
    
    private let registerSubject = CurrentValueSubject<User?, Never>(nil)
    
    func bindInputs() {
        registerSubject
            .compactMap { $0 }
            .sink(receiveValue: { [weak self] user in
                self?.requestRegister(email: user.email, password: user.password, name: user.name!)
            })
            .store(in: &bag)
    }
    
    func apply(_ input: Input) {
        switch input {
        case .registerTapped:
            registerSubject.send(User(email: self.id, password: self.password, name: self.nickname))
        }
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
        Publishers.CombineLatest(self.passwordValidPublisher,
                                  self.confirmPasswordValidPublisher)
            .dropFirst()
            .sink {_passwordValidator, _confirmPasswordValidator in

                self.enableSignUp =
                    _passwordValidator.errorMessage == nil &&
                    _confirmPasswordValidator.confirmPasswordErrorMessage == nil
        }
        .store(in: &bag)

        passwordValidPublisher
            .dropFirst()
            .sink { (_passwordValidator) in
                self.passwordError = _passwordValidator.errorMessage
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
    }
    
    func requestRegister(email: String, password: String, name: String) {
        apiManager.regiser(email: email, password: password, name: name)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
                    self?.isErrorAlert.toggle()
//                    self?.movieErrors.append(.moviesRequestFailed)
                }
//                self?.isLoading = false
            }, receiveValue: { [weak self] _ in
                // 회원가입 완료 창 뜨게 해
            })
            .store(in: &bag)
    }
    
    init() {
        self.apiManager = APIManager()
        bindInputs()
        bindOutputs()
    }

    deinit {
        bag.removeAll()
    }

}

extension SignupViewModel {
    
    func requestMovies() {
//      movieErrors.removeAll()
//      isLoading = trueㄴ
    }

}

extension String {
    func isValidPassword(pattern: String = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$") -> Bool {
        let passwordRegex = pattern
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
