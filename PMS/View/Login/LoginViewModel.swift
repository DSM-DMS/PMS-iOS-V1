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
    @Published var isAuto = false
    @Published var isHidden = true
    @Published var errorMsg = ""
    @Published var isAlert = false
    
    @Published var isLoading = false
    
    private var apiManager: APIManager
    private var bag = Set<AnyCancellable>()
    
    init() {
        self.apiManager = APIManager()
    }
    
    enum Input {
        case loginTapped(email: String, password: String)
    }
    
    private let loginSubject = CurrentValueSubject<User?, Never>(nil)
    
    func apply(_ input: Input) {
        switch input {
        case .loginTapped(let email, let password):
            loginSubject.send(User(email: email, password: password))
        //            didTapIndexSubject.send(index)
        }
    }
    
    func bindInputs() {
        loginSubject
            .compactMap { $0 }
            .sink(receiveValue: { [weak self] user in
                //            self?.sortMethod = sortMethod
                self?.requestLogin(email: user.email, password: user.password)
            })
            .store(in: &bag)
    }
    
    func requestLogin(email: String, password: String) {
        //      movieErrors.removeAll()
        isLoading = true
        
        apiManager.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure = completion {
//                    self?.movieErrors.append(.moviesRequestFailed)
                }
                self?.isLoading = false
            }, receiveValue: { [weak self] _ in
//                self?.movies = moviesResponse.movies
            })
            .store(in: &bag)
    }
}
