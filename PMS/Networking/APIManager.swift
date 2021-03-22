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
    
    func changeName(name: String) -> AnyPublisher<Void, MoyaError> {
        provider.requestVoidPublisher(.changeNickname(name: name))
    }
    
    func addStudent(number: Int) -> AnyPublisher<Void, MoyaError> {
        provider.requestVoidPublisher(.addStudent(number: number))
    }
    
    func getStudents() -> AnyPublisher<User, MoyaError> {
        provider.requestPublisher(.getStudents)
            .map(User.self)
    }
    
    func changePassword(password: String, prePassword: String) -> AnyPublisher<Void, MoyaError> {
        provider.requestVoidPublisher(.changePassword(password: password, prePassword: prePassword))
    }
    
    func getOutsideList(number: Int) -> AnyPublisher<OutsideList, MoyaError> {
        provider.requestPublisher(.outside(number: number))
            .map(OutsideList.self)
    }
    
    func getPointList(number: Int) -> AnyPublisher<PointList, MoyaError> {
        provider.requestPublisher(.pointList(number: number))
            .map(PointList.self)
    }
}
