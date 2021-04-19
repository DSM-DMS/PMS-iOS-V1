//
//  MypageDataRepo.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public class MypageDataRepo: MypageDomainRepoInterface {
    let mypageRemoteDataSource: MypageRemoteDataSourceInterface
    let mypageLocalDataSource: MypageLocalDataSourceInterface
    
    public init(mypageRemoteDataSource: MypageRemoteDataSourceInterface,
                mypageLocalDataSource: MypageLocalDataSourceInterface) {
        self.mypageRemoteDataSource = mypageRemoteDataSource
        self.mypageLocalDataSource = mypageLocalDataSource
        
    }
    
    public func mypage(number: Int, completion: @escaping (Result<Student, Error>) -> Void) {
        mypageRemoteDataSource.mypage(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                self.mypageLocalDataSource.getCachedStudent { result in
                    switch result {
                    case let .success(success):
                        return completion(.success(success))
                    case let .failure(error):
                        print(error)
                        return completion(.failure(error))
                    }
                }
            }
        }
    }
    
    public func getStudent(completion: @escaping (Result<[User], Error>) -> Void) {
        mypageRemoteDataSource.getStudent { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func changeNickname(name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        mypageRemoteDataSource.changeNickname(name: name) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        mypageRemoteDataSource.changePassword(password: password, prePassword: prePassword) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func addStudent(number: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        mypageRemoteDataSource.addStudent(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getPointList(number: Int, completion: @escaping (Result<PointList, Error>) -> Void) {
        mypageRemoteDataSource.getPointList(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getOutingList(number: Int, completion: @escaping (Result<OutsideList, Error>) -> Void) {
        mypageRemoteDataSource.getOutingList(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
}
