//
//  LoginDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public protocol LoginDomainRepoInterface {
    func login(email: String, password: String, completion: @escaping (Result<accessToken, GEError>) -> Void)
    func register(email: String, password: String, name: String, completion: @escaping (Result<Void, GEError>) -> Void)
}
