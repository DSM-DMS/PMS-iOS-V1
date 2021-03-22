//
//  APIManager.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/09.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Combine
import Moya

class APIManager {
    let provider = MoyaProvider<PMSApi>()
    // MARK: Auth
    
    func login(email: String, password: String) -> AnyPublisher<accessToken, MoyaError> {
        provider.requestPublisher(.login(email: email, password: password))
            .map(accessToken.self)
    }
    
    func regiser(email: String, password: String, name: String) -> AnyPublisher<Void, MoyaError> {
        provider.requestVoidPublisher(.register(email: email, password: password, name: name))
    }
    
    // MARK: Mypage
    
    func mypage(number: Int) -> AnyPublisher<Student, MoyaError> {
        provider.requestPublisher(.mypage(number: number))
            .map(Student.self)
    }
    
    func addStudent(number: Int) -> AnyPublisher<Void, MoyaError> {
        provider.requestVoidPublisher(.addStudent(number: number))
    }
    
    func getStudents() -> AnyPublisher<User, MoyaError> {
        provider.requestPublisher(.getStudents)
            .map(User.self)
    }
    
//    func changePassword(password: String, prePassword: String) -> AnyPublisher<accessToken, MoyaError> {
//        let authPlugin = AccessTokenPlugin { _ in self.tokenClosure}
//        let authProvider = MoyaProvider<PMSApi>(plugins: [authPlugin])
//
//        return authProvider.requestPublisher(.changePassword(password: password, prePassword: prePassword))
//            .map(accessToken.self)
//    }
}
