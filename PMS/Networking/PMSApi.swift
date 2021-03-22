//
//  PMSApi.swift
//  PMS
//
//  Created by jge on 2020/10/13.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Moya

enum PMSApi {
    // Auth
    case login(email: String, password: String)
    case register(email: String, password: String, name: String)
    
    // Calendar
    case calendar
    
    // Meal
    case meal
    case mealPicture
    
    // Notice
    case notice
    case letter
    case noticeDetail(_ id: Int)
    case letterDetail(_ id: Int)
    
    case addComment(_ id: Int)
    case filePath(_ id: Int)
    
    // Introduce
    case clubs
    case clubDetail(_ id: Int)
    case companys
    case companyDetail(_ id: Int)
    
    // Mypage
    case mypage(number: Int)
    case changeNickname(name: String)
    case addStudent(number: Int)
    case getStudents
    case outside(_ id: Int)
    case changePassword(password: String, prePassword: String)
}

extension PMSApi: TargetType {
    var baseURL: URL {
        return URL(string: "http://api.smooth-bear.live")!
    }
    
    var path: String {
        switch self {
        // Auth
        case .login:
            return "/auth"
        case .register:
            return "/user"
            
        // Calendar
        case .calendar:
            return "/calendar"
            
        // Meal
        case .meal:
            return "/event/meal"
        case .mealPicture:
            return "/event/meal/picture"
            
        // Notice
        case .notice:
            return "/notice"
        case .letter:
            return "/notice/home"
        case .noticeDetail(let id):
            return "/notice/\(id)"
        case .letterDetail(let id):
            return "/notice/home/\(id)"
        case .addComment:
            return "/notice/comment"
        case .filePath(let id):
            return "/notice/download/\(id)"
            
        // Introduce
        case .clubs:
            return "/introduce/clubs"
        case .clubDetail(let id):
            return "/introduce/clubs/\(id)"
        case .companys:
            return "/introduce/company"
        case .companyDetail(let id):
            return "/introduce/clubs/\(id)"
            
        // Mypage
        case .mypage(let number):
            return "/user/student/\(number)"
        case .changeNickname:
            return "/user/name"
        case .addStudent:
            return "/user/student"
        case .getStudents:
            return "/user"
        case .outside(let id):
            return "/user/student/outing/\(id)"
        case .changePassword:
            return "/auth/password"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .register, .changePassword, .addComment:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    // 기본요청(plain request), 데이터 요청(data request), 파라미터 요청(parameter request), 업로드 요청(upload request) 등
    var task: Task {
        switch self {
        case let .register(email, password, name):
            return .requestParameters(parameters: ["email": email, "password": password, "name": name], encoding: JSONEncoding.default)
        case let .login(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case let .changePassword(password, prePassword):
            return .requestParameters(parameters: ["password": password, "pre-password": prePassword], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getStudents:
            return ["Authorization": "Bearer " + UDManager.shared.token!]
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    // HTTP code가 200에서 299사이인 경우 요청이 성공한 것으로 간주된다.
    public var validationType: ValidationType {
        return .successCodes
    }
}
