//
//  MypageDataRepo.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import domain
import Combine

public class MypageDataRepo: MypageDomainRepoInterface {
    let mypageRemoteDataSource: MypageRemoteDataSourceInterface
    let mypageLocalDataSource: MypageLocalDataSourceInterface
    
    public init(mypageRemoteDataSource: MypageRemoteDataSourceInterface,
                mypageLocalDataSource: MypageLocalDataSourceInterface) {
        self.mypageRemoteDataSource = mypageRemoteDataSource
        self.mypageLocalDataSource = mypageLocalDataSource
    }
    public func mypage(number: Int) -> AnyPublisher<Student, GEError> {
        mypageRemoteDataSource.mypage(number: number)
            .catch { [weak self] _ in
                return (self?.mypageLocalDataSource.getCachedStudent()) ??
                    Just(Student(plus: 0, minus: 0, status: 0, isMeal: true))
                    .setFailureType(to: GEError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    public func getStudent() -> AnyPublisher<User, GEError> {
        mypageRemoteDataSource.getStudent()
    }
    public func changeNickname(name: String) -> AnyPublisher<Void, GEError> {
        mypageRemoteDataSource.changeNickname(name: name)
    }
    public func changePassword(password: String, prePassword: String) -> AnyPublisher<Void, GEError> {
        mypageRemoteDataSource.changePassword(password: password, prePassword: prePassword)
    }
    public func addStudent(number: Int) -> AnyPublisher<Void, GEError> {
        mypageRemoteDataSource.addStudent(number: number)
    }
    public func getPointList(number: Int) -> AnyPublisher<PointList, GEError> {
        mypageRemoteDataSource.getPointList(number: number)
    }
    public func getOutingList(number: Int) -> AnyPublisher<OutsideList, GEError> {
        mypageRemoteDataSource.getOutingList(number: number)
    }
    public func deleteStudent(number: Int) -> AnyPublisher<Void, GEError> {
        mypageRemoteDataSource.deleteStudent(number: number)
    }
}
