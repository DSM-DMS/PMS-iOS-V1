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

//    private var webService: WebService

    private var cancellableBag = Set<AnyCancellable>()

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var inputImage: UIImage?

    @Published var statusViewModel: StatusViewModel = StatusViewModel(title: "")

    @Published var emailError: String? = ""
    @Published var passwordError: String? = ""
    @Published var confirmPasswordError: String? = ""
    @Published var enableSignUp: Bool = false

    private var emailValidPublisher: AnyPublisher<EmailValidation, Never> {

        $email
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

    init() {

//        self.webService = WebService()

        Publishers.CombineLatest3(self.emailValidPublisher,
                                  self.passwordValidPublisher,
                                  self.confirmPasswordValidPublisher)
            .dropFirst()
            .sink {_emailError, _passwordValidator, _confirmPasswordValidator in

                self.enableSignUp = _emailError.errorMessage == nil &&
                    _passwordValidator.errorMessage == nil &&
                    _confirmPasswordValidator.confirmPasswordErrorMessage == nil
        }
        .store(in: &cancellableBag)

        emailValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { (_emailError) in
                self.emailError = _emailError.errorMessage
        }
        .store(in: &cancellableBag)

        passwordValidPublisher
            .dropFirst()
            .sink { (_passwordValidator) in
                self.passwordError = _passwordValidator.errorMessage
        }
        .store(in: &cancellableBag)

        confirmPasswordValidPublisher
            .dropFirst()
            .sink { (_confirmPasswordValidator) in
                self.confirmPasswordError = _confirmPasswordValidator.confirmPasswordErrorMessage
        }
        .store(in: &cancellableBag)
    }

    deinit {
        cancellableBag.removeAll()
    }

}

extension SignupViewModel {

//    func register() {
//
//        let user = User(email: self.email, name: self.name, password: self.password)
//
//        self.webService.signup(user: user) { _ in
//
//        }
//
//    }

//    func uploadImage() {
//
//        self.webService.uploadJPG("http://127.0.0.1:8000/image/", image: self.inputImage!) { _ in
//
//        }
//    }

}

extension String {
    // Evaluates what the user entered to ensure it's a valid email address
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
