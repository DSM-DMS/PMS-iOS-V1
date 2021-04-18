//
//  MypageRemoteRepository.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/16.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Moya

public protocol MypageRemoteDataSourceInterface {
    func requestStudent(number: Int, completion: @escaping (Result<[Student], Error>) -> Void)
    func changeNickname(name: String, completion: @escaping (Result<Void, Error>) -> Void)
    func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, Error>) -> Void)
    func addStudent(number: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func getPointList(number: Int, completion: @escaping (Result<[PointList], Error>) -> Void)
}

public class MypageRemoteDataSource: MypageRemoteDataSourceInterface {
    let provider: MoyaProvider<AuthApi>
    
    init(provider: MoyaProvider<AuthApi> = MoyaProvider<AuthApi>()) {
        self.provider = provider
    }
    
    public func requestStudent(number: Int, completion: @escaping (Result<[Student], Error>) -> Void) {
        provider.request(.mypage(number: number)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let students = try JSONDecoder().decode([Student].self, from: responseData)
                    return completion(.success(students))
                } catch {
                    return completion(.failure(error))
                }
            case let .failure(error):
                print(error)
                return completion(.failure(error))
            }
        }
    }
    
    public func changeNickname(name: String, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.changeNickname(name: name)) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case let .failure(error):
                print(error)
                return completion(.failure(error))
            }
        }
    }
    
    public func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.changePassword(password: password, prePassword: prePassword)) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case let .failure(error):
                print(error)
                return completion(.failure(error))
            }
        }
    }
    
    public func addStudent(number: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.addStudent(number: number)) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case let .failure(error):
                print(error)
                return completion(.failure(error))
            }
        }
    }
    
    public func getPointList(number: Int, completion: @escaping (Result<[PointList], Error>) -> Void) {
        provider.request(.mypage(number: number)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let pointList = try JSONDecoder().decode([PointList].self, from: responseData)
                    return completion(.success(pointList))
                } catch {
                    return completion(.failure(error))
                }
            case let .failure(error):
                print(error)
                return completion(.failure(error))
            }
        }
    }
    
}
