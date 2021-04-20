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
    
    private var bag = Set<AnyCancellable>()
    
    private var loginInteractor: LoginInteractorInterface
    private var authDataRepo: AuthDomainRepoInterface
    
    public init(loginInteractor: LoginInteractorInterface, authDataRepo: AuthDomainRepoInterface) {
        self.loginInteractor = loginInteractor
        self.authDataRepo = authDataRepo
        bindInputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    enum Input {
        case loginTapped
    }
    
    private let loginSubject = CurrentValueSubject<Auth?, Never>(nil)
    
    func apply(_ input: Input) {
        switch input {
        case .loginTapped:
            loginSubject.send(Auth(email: self.id, password: self.password))
        }
    }
    
    func bindInputs() {
        loginSubject
            .compactMap { $0 }
            .sink(receiveValue: { [weak self] user in
                self?.requestLogin(email: user.email, password: user.password)
                UDManager.shared.email = user.email
                UDManager.shared.password = user.password
            })
            .store(in: &bag)
    }
    
    func requestLogin(email: String, password: String) {
        loginInteractor.login(email: email, password: password) { [weak self] result in
            switch result {
            case let .success(token):
                self?.isSuccessAlert.toggle()
                UDManager.shared.token = token.accessToken
                self?.authDataRepo.getStudent()
            case let .failure(error):
                if error == .unauthorized {
                    self?.isNotMatchError.toggle()
                } else if error == .noInternet {
                    self?.isNotInternet.toggle()
                }
            }
        }
    }
}
