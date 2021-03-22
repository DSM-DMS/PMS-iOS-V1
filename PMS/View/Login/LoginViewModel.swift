//
//  LoginViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var id = ""
    @Published var password = ""
    @Published var isHidden = true
    @Published var errorMsg = ""
    @Published var isNotMatchError = false
    @Published var isNotInternet = false
    @Published var isSuccessAlert = false
    
    private var apiManager: APIManager
    private var bag = Set<AnyCancellable>()
    
    init() {
        self.apiManager = APIManager()
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
        apiManager.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    if error.response?.statusCode == 401 {
                        self?.isNotMatchError.toggle()
                    } else if error.errorCode == 6 {
                        self?.isNotInternet.toggle()
                    }
                    print(error)
                    
                }
            }, receiveValue: { [weak self] token in
                self?.isSuccessAlert.toggle()
                UDManager.shared.token = token.accessToken
                AuthManager.shared.requestStudent()
            })
            .store(in: &bag)
    }
}
