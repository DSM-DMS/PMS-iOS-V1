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
    @Published var isErrorAlert = false
    @Published var isSuccessAlert = false
    
    private var apiManager: APIManager
    private var bag = Set<AnyCancellable>()
    
    init() {
        self.apiManager = APIManager()
        bindInputs()
    }
    
    enum Input {
        case loginTapped
    }
    
    private let loginSubject = CurrentValueSubject<User?, Never>(nil)
    
    func apply(_ input: Input) {
        switch input {
        case .loginTapped:
            loginSubject.send(User(email: self.id, password: self.password))
        }
    }
    
    func bindInputs() {
        loginSubject
            .compactMap { $0 }
            .sink(receiveValue: { [weak self] user in
                self?.requestLogin(email: user.email, password: user.password)
            })
            .store(in: &bag)
    }
    
    func requestLogin(email: String, password: String) {
        //      movieErrors.removeAll()
        apiManager.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.isErrorAlert.toggle()
                    if error.response?.statusCode == 401 {
                        // 뭔가 함
                    }
                }
            }, receiveValue: { [weak self] token in
                self?.isSuccessAlert.toggle()
                UD.set(token.accessToken, forKey: "accessToken")
            })
            .store(in: &bag)
    }
}
