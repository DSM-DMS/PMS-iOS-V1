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

    @Published var id: String = ""
    @Published var password: String = ""
    @Published var nickname: String = ""
    @Published var confirmPassword: String = ""
    @Published var isHidden = false
    @Published var inputImage: UIImage?

    @Published var statusViewModel: StatusViewModel = StatusViewModel(title: "")

    @Published var isAlert: Bool = true
    @Published var passwordError: String? = ""
    @Published var confirmIsError: Bool = false
    @Published var confirmErrorMsg: String? = ""
    @Published var enableSignUp: Bool = false

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

        Publishers.CombineLatest(self.passwordValidPublisher,
                                  self.confirmPasswordValidPublisher)
            .dropFirst()
            .sink {_passwordValidator, _confirmPasswordValidator in

                self.enableSignUp =
                    _passwordValidator.errorMessage == nil &&
                    _confirmPasswordValidator.confirmPasswordErrorMessage == nil
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
                self.confirmErrorMsg = _confirmPasswordValidator.confirmPasswordErrorMessage
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
    func isValidPassword(pattern: String = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$") -> Bool {
        let passwordRegex = pattern
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
