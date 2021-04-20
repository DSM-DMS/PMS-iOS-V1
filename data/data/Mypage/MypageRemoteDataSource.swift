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

public protocol MypageRemoteDataSourceInterface {
    func mypage(number: Int, completion: @escaping (Result<Student, GEError>) -> Void)
    func getStudent(completion: @escaping (Result<User, GEError>) -> Void)
    func changeNickname(name: String, completion: @escaping (Result<Void, GEError>) -> Void)
    func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, GEError>) -> Void)
    func addStudent(number: Int, completion: @escaping (Result<Void, GEError>) -> Void)
    func getPointList(number: Int, completion: @escaping (Result<PointList, GEError>) -> Void)
    func getOutingList(number: Int, completion: @escaping (Result<OutsideList, GEError>) -> Void)
}

public class MypageRemoteDataSource: MypageRemoteDataSourceInterface {
    let provider: MoyaProvider<AuthApi>
    
    public init(provider: MoyaProvider<AuthApi> = MoyaProvider<AuthApi>()) {
        self.provider = provider
    }
    
    public func mypage(number: Int, completion: @escaping (Result<Student, GEError>) -> Void) {
        provider.request(.mypage(number: number)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let students = try JSONDecoder().decode(Student.self, from: responseData)
                    return completion(.success(students))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func getStudent(completion: @escaping (Result<User, GEError>) -> Void) {
        provider.request(.getStudents) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let user = try JSONDecoder().decode(User.self, from: responseData)
                    return completion(.success(user))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func changeNickname(name: String, completion: @escaping (Result<Void, GEError>) -> Void) {
        provider.request(.changeNickname(name: name)) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, GEError>) -> Void) {
        provider.request(.changePassword(password: password, prePassword: prePassword)) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func addStudent(number: Int, completion: @escaping (Result<Void, GEError>) -> Void) {
        provider.request(.addStudent(number: number)) { result in
            switch result {
            case .success:
                return completion(.success(()))
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func getPointList(number: Int, completion: @escaping (Result<PointList, GEError>) -> Void) {
        provider.request(.pointList(number: number)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let pointList = try JSONDecoder().decode(PointList.self, from: responseData)
                    return completion(.success(pointList))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func getOutingList(number: Int, completion: @escaping (Result<OutsideList, GEError>) -> Void) {
        provider.request(.outside(number: number)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let pointList = try JSONDecoder().decode(OutsideList.self, from: responseData)
                    return completion(.success(pointList))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
}
