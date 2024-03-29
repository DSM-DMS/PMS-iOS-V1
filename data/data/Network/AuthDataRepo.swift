//
//  AuthDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import Combine
import domain
import Moya

public class AuthDataRepo: AuthDomainRepoInterface {
    let provider = MoyaProvider<AuthApi>()
    
    public init() {}
    
    public func refreshToken() {
        if UDManager.shared.isLogin == false {
            provider.request(.login(email: "test@test.com", password: "testpass")) { result in
                switch result {
                case let .success(success):
                    let responseData = success.data
                    do {
                        let token = try JSONDecoder().decode(accessToken.self, from: responseData)
                        UDManager.shared.token = token.accessToken
                    } catch {
                        print("map error")
                    }
                case .failure:
                    break
                }
            }
        } else {
            provider.request(.login(email: UDManager.shared.email!, password: UDManager.shared.password!)) { result in
                switch result {
                case let .success(success):
                    let responseData = success.data
                    do {
                        let token = try JSONDecoder().decode(accessToken.self, from: responseData)
                        UDManager.shared.token = token.accessToken
                    } catch {
                        print("map error")
                    }
                case let .failure(error):
                    if error.response?.statusCode == 401 {
                        print("the email & password not match")
                    } else if error.errorCode == 6 {
                        print("you're not in internet")
                    }
                    print(error)
                }
            }
        }
        
    }
    
    public func getStudent() -> AnyPublisher<User, GEError> {
        provider.requestPublisher(.getStudents)
            .map(User.self)
            .mapError { error in
                return mapGEEror(error)
            }.eraseToAnyPublisher()
    }
    
    public func resetStudent() {
        provider.request(.getStudents) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    var user = try JSONDecoder().decode(User.self, from: responseData)
                    UDManager.shared.name = user.name
                    if !user.students.isEmpty {
                        user.students.sort { $0.number < $1.number }
                        let firstuser: String = String(user.students.first!.number) + " " + user.students.first!.name
                        UDManager.shared.currentStudent = firstuser
                    }
                } catch {
                    print("map error")
                }
            case let .failure(error):
                if error.response?.statusCode == 401 {
                    self.refreshToken()
                } else if error.errorCode == 6 {
                    print("you're not in internet")
                }
                print(error)
            }
        }
    }
}
