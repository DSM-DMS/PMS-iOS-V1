//
//  PMSApi.swift
//  PMS
//
//  Created by jge on 2020/10/13.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Moya
import domain

public enum AuthApi {
    // Auth
    case login(email: String, password: String)
    case register(email: String, password: String, name: String)
    
    // Mypage
    case mypage(number: Int)
    case changeNickname(name: String)
    case addStudent(number: Int)
    case getStudents
    case deleteStudent(number: Int)
    case outside(number: Int)
    case changePassword(password: String, prePassword: String)
    case pointList(number: Int)
}

extension AuthApi: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.smooth-bear.live")!
    }
    
    public var path: String {
        switch self {
        // Auth
        case .login:
            return "/auth"
        case .register:
            return "/user"
            
        // Mypage
        case .mypage(let number):
            return "/user/student/\(number)"
        case .changeNickname:
            return "/user/name"
        case .addStudent:
            return "/user/student"
        case .getStudents:
            return "/user"
        case .outside(let number):
            return "/user/student/outing/\(number)"
        case .changePassword:
            return "/auth/password"
        case .pointList(number: let number):
            return "/user/student/point/\(number)"
        case .deleteStudent:
            return "/user/student"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .register, .addStudent:
            return .post
        case .changePassword, .changeNickname:
            return .put
        case .deleteStudent:
            return .delete
        default:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    // 기본요청(plain request), 데이터 요청(data request), 파라미터 요청(parameter request), 업로드 요청(upload request) 등
    public var task: Task {
        switch self {
        case let .register(email, password, name):
            return .requestParameters(parameters: ["email": email, "password": password, "name": name], encoding: JSONEncoding.default)
        case let .login(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case let .changePassword(password, prePassword):
            return .requestParameters(parameters: ["password": password, "pre-password": prePassword], encoding: JSONEncoding.default)
        case let.addStudent(number):
            return .requestParameters(parameters: ["number": number], encoding: JSONEncoding.default)
        case let .changeNickname(name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .login, .register:
            return ["Content-type": "application/json"]
        default:
            return ["Authorization": "Bearer " + UDManager.shared.token!]
        }
    }
    
    // HTTP code가 200에서 299사이인 경우 요청이 성공한 것으로 간주된다.
    public var validationType: ValidationType {
        return .successCodes
    }
}
