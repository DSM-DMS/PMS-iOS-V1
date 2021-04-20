//
//  LoginDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain

public class LoginDataRepo: LoginDomainRepoInterface {
    let loginRemoteDataSource: LoginRemoteDataSourceInterface
    
    public init(loginRemoteDataSource: LoginRemoteDataSourceInterface) {
        self.loginRemoteDataSource = loginRemoteDataSource
        
    }
    
    public func login(email: String, password: String, completion: @escaping (Result<accessToken, GEError>) -> Void) {
        loginRemoteDataSource.login(email: email, password: password) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func register(email: String, password: String, name: String, completion: @escaping (Result<Void, GEError>) -> Void) {
        loginRemoteDataSource.register(email: email, password: password, name: name) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
}
