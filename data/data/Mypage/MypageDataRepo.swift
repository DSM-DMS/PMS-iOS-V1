//
//  MypageDataRepo.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import domain

public class MypageDataRepo: MypageDomainRepoInterface {
    let mypageRemoteDataSource: MypageRemoteDataSourceInterface
    let mypageLocalDataSource: MypageLocalDataSourceInterface
    
    public init(mypageRemoteDataSource: MypageRemoteDataSourceInterface,
                mypageLocalDataSource: MypageLocalDataSourceInterface) {
        self.mypageRemoteDataSource = mypageRemoteDataSource
        self.mypageLocalDataSource = mypageLocalDataSource
        
    }
    
    public func mypage(number: Int, completion: @escaping (Result<Student, GEError>) -> Void) {
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
    
    public func getStudent(completion: @escaping (Result<User, GEError>) -> Void) {
        mypageRemoteDataSource.getStudent { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func changeNickname(name: String, completion: @escaping (Result<Void, GEError>) -> Void) {
        mypageRemoteDataSource.changeNickname(name: name) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, GEError>) -> Void) {
        mypageRemoteDataSource.changePassword(password: password, prePassword: prePassword) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func addStudent(number: Int, completion: @escaping (Result<Void, GEError>) -> Void) {
        mypageRemoteDataSource.addStudent(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getPointList(number: Int, completion: @escaping (Result<PointList, GEError>) -> Void) {
        mypageRemoteDataSource.getPointList(number: number) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getOutingList(number: Int, completion: @escaping (Result<OutsideList, GEError>) -> Void) {
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
