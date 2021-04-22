//
//  MypageRemoteRepository.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/16.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import domain
import Moya
import Combine

public protocol MypageRemoteDataSourceInterface {
    func mypage(number: Int) -> AnyPublisher<Student, GEError>
    func getStudent() -> AnyPublisher<User, GEError>
    func changeNickname(name: String) -> AnyPublisher<Void, GEError>
    func changePassword(password: String, prePassword: String) -> AnyPublisher<Void, GEError>
    func addStudent(number: Int) -> AnyPublisher<Void, GEError>
    func getPointList(number: Int) -> AnyPublisher<PointList, GEError>
    func getOutingList(number: Int) -> AnyPublisher<OutsideList, GEError>
}

public class MypageRemoteDataSource: MypageRemoteDataSourceInterface {
    let provider: MoyaProvider<AuthApi>
    
    public init(provider: MoyaProvider<AuthApi> = MoyaProvider<AuthApi>()) {
        self.provider = provider
    }
    
    public func mypage(number: Int) -> AnyPublisher<Student, GEError> {
        provider.requestPublisher(.mypage(number: number))
            .map(Student.self)
            .mapError { error in mapGEEror(error)}
            .eraseToAnyPublisher()
    }
    
    public func getStudent() -> AnyPublisher<User, GEError> {
        provider.requestPublisher(.getStudents)
            .map(User.self)
            .mapError { error in mapGEEror(error)}
            .eraseToAnyPublisher()
    }
    
    public func changeNickname(name: String) -> AnyPublisher<Void, GEError> {
        provider.requestVoidPublisher(.changeNickname(name: name))
            .mapError { error in mapGEEror(error)}
            .eraseToAnyPublisher()
    }
    
    public func changePassword(password: String, prePassword: String) -> AnyPublisher<Void, GEError> {
        provider.requestVoidPublisher(.changePassword(password: password, prePassword: prePassword))
            .mapError { error in mapGEEror(error)}
            .eraseToAnyPublisher()
    }
    
    public func addStudent(number: Int) -> AnyPublisher<Void, GEError> {
        provider.requestVoidPublisher(.addStudent(number: number))
            .mapError { error in mapGEEror(error)}
            .eraseToAnyPublisher()
    }
    
    public func getPointList(number: Int) -> AnyPublisher<PointList, GEError> {
        provider.requestPublisher(.pointList(number: number))
            .map(PointList.self)
            .mapError { error in mapGEEror(error)}
            .eraseToAnyPublisher()
    }
    
    public func getOutingList(number: Int) -> AnyPublisher<OutsideList, GEError> {
        provider.requestPublisher(.outside(number: number))
            .map(OutsideList.self)
            .mapError { error in mapGEEror(error)}
            .eraseToAnyPublisher()
    }
}
