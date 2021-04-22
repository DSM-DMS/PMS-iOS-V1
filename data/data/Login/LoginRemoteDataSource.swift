//
//  LoginRemoteDataSource.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import Combine
import domain
import Moya

public protocol LoginRemoteDataSourceInterface {
    func login(email: String, password: String) -> AnyPublisher<accessToken, GEError>
    func register(email: String, password: String, name: String) -> AnyPublisher<Void, GEError>
}

public class LoginRemoteDataSource: LoginRemoteDataSourceInterface {
    let provider: MoyaProvider<AuthApi>
    
    public init(provider: MoyaProvider<AuthApi> = MoyaProvider<AuthApi>()) {
        self.provider = provider
    }
    
    public func login(email: String, password: String) -> AnyPublisher<accessToken, GEError> {
        provider.requestPublisher(.login(email: email, password: password))
            .map(accessToken.self)
            .mapError { error -> GEError in
                mapGEEror(error)
            }.eraseToAnyPublisher()
    }
    
    public func register(email: String, password: String, name: String) -> AnyPublisher<Void, GEError> {
        provider.requestVoidPublisher(.register(email: email, password: password, name: name))
            .mapError { error -> GEError in
                mapGEEror(error)
            }.eraseToAnyPublisher()
    }
}
