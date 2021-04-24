//
//  MypageInteractor.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Combine

public protocol MypageInteractorInterface {
    func mypage(number: Int) -> AnyPublisher<Student, GEError>
    func getStudent() -> AnyPublisher<User, GEError>
    func changeNickname(name: String) -> AnyPublisher<Void, GEError>
    func changePassword(password: String, prePassword: String) -> AnyPublisher<Void, GEError>
    func addStudent(number: Int) -> AnyPublisher<Void, GEError>
    func getPointList(number: Int) -> AnyPublisher<PointList, GEError>
    func getOutingList(number: Int) -> AnyPublisher<OutsideList, GEError>
    func deleteStudent(number: Int) -> AnyPublisher<Void, GEError>
}

public class MypageInteractor: MypageInteractorInterface {
    let mypageDomainRepo: MypageDomainRepoInterface
    
    public init(mypageDomainRepo: MypageDomainRepoInterface) {
        self.mypageDomainRepo = mypageDomainRepo
    }
    
    public func mypage(number: Int) -> AnyPublisher<Student, GEError> {
        return mypageDomainRepo.mypage(number: number)
    }
    
    public func getStudent() -> AnyPublisher<User, GEError> {
        mypageDomainRepo.getStudent()
    }
    
    public func changeNickname(name: String) -> AnyPublisher<Void, GEError> {
        mypageDomainRepo.changeNickname(name: name)
    }
    
    public func changePassword(password: String, prePassword: String) -> AnyPublisher<Void, GEError> {
        mypageDomainRepo.changePassword(password: password, prePassword: prePassword)
    }
    
    public func addStudent(number: Int) -> AnyPublisher<Void, GEError> {
        mypageDomainRepo.addStudent(number: number)
    }
    
    public func getPointList(number: Int) -> AnyPublisher<PointList, GEError> {
        mypageDomainRepo.getPointList(number: number)
    }
    
    public func getOutingList(number: Int) -> AnyPublisher<OutsideList, GEError> {
        mypageDomainRepo.getOutingList(number: number)
    }
    
    public func deleteStudent(number: Int) -> AnyPublisher<Void, GEError> {
        mypageDomainRepo.deleteStudent(number: number)
    }
}
