//
//  MypageDomainRepoInterface.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Combine

public protocol MypageDomainRepoInterface {
    func mypage(number: Int) -> AnyPublisher<Student, GEError>
    func getStudent() -> AnyPublisher<User, GEError>
    func changeNickname(name: String) -> AnyPublisher<Void, GEError>
    func changePassword(password: String, prePassword: String) -> AnyPublisher<Void, GEError>
    func addStudent(number: Int) -> AnyPublisher<Void, GEError>
    func getPointList(number: Int) -> AnyPublisher<PointList, GEError>
    func getOutingList(number: Int) -> AnyPublisher<OutsideList, GEError>
    func deleteStudent(number: Int) -> AnyPublisher<Void, GEError>
}
