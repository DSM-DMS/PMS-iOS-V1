//
//  LoginRemoteDataSource.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain
import Moya

public protocol LoginRemoteDataSourceInterface {
    func login(email: String, password: String, completion: @escaping (Result<accessToken, GEError>) -> Void)
    func register(email: String, password: String, name: String, completion: @escaping (Result<Void, GEError>) -> Void)
}

public class LoginRemoteDataSource: LoginRemoteDataSourceInterface {
    let provider: MoyaProvider<AuthApi>
    
    public init(provider: MoyaProvider<AuthApi> = MoyaProvider<AuthApi>()) {
        self.provider = provider
    }
    
    public func login(email: String, password: String, completion: @escaping (Result<accessToken, GEError>) -> Void) {
        provider.request(.login(email: email, password: password)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let token = try JSONDecoder().decode(accessToken.self, from: responseData)
                    return completion(.success(token))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.errorCode == 6 {
                    return completion(.failure(GEError.noInternet))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func register(email: String, password: String, name: String, completion: @escaping (Result<Void, GEError>) -> Void) {
        provider.request(.register(email: email, password: password, name: name)) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.errorCode == 6 {
                    return completion(.failure(GEError.noInternet))
                }
                return completion(.failure(GEError.error))
            }
        }

    }
    
}
