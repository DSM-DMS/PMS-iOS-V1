//
//  LoginDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Combine
import Moya
import domain

public class LoginDataRepo: LoginDomainRepoInterface {
    let loginRemoteDataSource: LoginRemoteDataSourceInterface
    
    public init(loginRemoteDataSource: LoginRemoteDataSourceInterface) {
        self.loginRemoteDataSource = loginRemoteDataSource
    }
    
    public func login(email: String, password: String) -> AnyPublisher<accessToken, GEError> {
        return loginRemoteDataSource.login(email: email, password: password)
    }
    
    public func register(email: String, password: String, name: String) -> AnyPublisher<Void, GEError> {
        return loginRemoteDataSource.register(email: email, password: password, name: name)
    }
}
