//
//  LoginInteractor.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Combine

public protocol LoginInteractorInterface {
    func login(email: String, password: String) -> AnyPublisher<accessToken, GEError>
    func register(email: String, password: String, name: String) -> AnyPublisher<Void, GEError>
}

public class LoginInteractor: LoginInteractorInterface {
    let loginDomainRepo: LoginDomainRepoInterface
    
    public init(loginDomainRepo: LoginDomainRepoInterface) {
        self.loginDomainRepo = loginDomainRepo
    }
    
    public func login(email: String, password: String) -> AnyPublisher<accessToken, GEError> {
        return loginDomainRepo.login(email: email, password: password)
    }
    
    public func register(email: String, password: String, name: String) -> AnyPublisher<Void, GEError> {
        return loginDomainRepo.register(email: email, password: password, name: name)
    }
}
