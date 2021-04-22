//
//  LoginDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Combine

public protocol LoginDomainRepoInterface {
    func login(email: String, password: String) -> AnyPublisher<accessToken, GEError>
    func register(email: String, password: String, name: String) -> AnyPublisher<Void, GEError>
}
