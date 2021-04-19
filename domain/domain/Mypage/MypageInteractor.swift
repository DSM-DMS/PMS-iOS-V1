//
//  MypageInteractor.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public protocol MypageInteractorInterface {
    func mypage(number: Int, completion: @escaping (Result<Student, Error>) -> Void)
    func getStudent(completion: @escaping (Result<[User], Error>) -> Void)
    func changeNickname(name: String, completion: @escaping (Result<Void, Error>) -> Void)
    func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, Error>) -> Void)
    func addStudent(number: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func getPointList(number: Int, completion: @escaping (Result<PointList, Error>) -> Void)
    func getOutingList(number: Int, completion: @escaping (Result<OutsideList, Error>) -> Void)
}

public class MypageInteractor: MypageInteractorInterface {
    let mypageDomainRepo: MypageDomainRepoInterface
    
    public init(mypageDomainRepo: MypageDomainRepoInterface) {
        self.mypageDomainRepo = mypageDomainRepo
    }
    
    public func mypage(number: Int, completion: @escaping (Result<Student, Error>) -> Void) {
        mypageDomainRepo.mypage(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getStudent(completion: @escaping (Result<[User], Error>) -> Void) {
        mypageDomainRepo.getStudent { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func changeNickname(name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        mypageDomainRepo.changeNickname(name: name) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        mypageDomainRepo.changePassword(password: password, prePassword: prePassword) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func addStudent(number: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        mypageDomainRepo.addStudent(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getPointList(number: Int, completion: @escaping (Result<PointList, Error>) -> Void) {
        mypageDomainRepo.getPointList(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getOutingList(number: Int, completion: @escaping (Result<OutsideList, Error>) -> Void) {
        mypageDomainRepo.getOutingList(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
}
