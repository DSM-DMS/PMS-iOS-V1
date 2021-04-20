//
//  LoginInteractor.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public protocol LoginInteractorInterface {
    func login(email: String, password: String, completion: @escaping (Result<accessToken, GEError>) -> Void)
    func register(email: String, password: String, name: String, completion: @escaping (Result<Void, GEError>) -> Void)
}

public class LoginInteractor: LoginInteractorInterface {
    let loginDomainRepo: LoginDomainRepoInterface
    
    public init(loginDomainRepo: LoginDomainRepoInterface) {
        self.loginDomainRepo = loginDomainRepo
    }
    
    public func login(email: String, password: String, completion: @escaping (Result<accessToken, GEError>) -> Void) {
        loginDomainRepo.login(email: email, password: password) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func register(email: String, password: String, name: String, completion: @escaping (Result<Void, GEError>) -> Void) {
        loginDomainRepo.register(email: email, password: password, name: name) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
}
