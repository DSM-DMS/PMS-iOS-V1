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
    case login
    case register
    
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
    case mypage
    case changeNickname
    case addStudent
    case outside
    case weekStatus
    case changePassword
}

extension PMSApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://127.0.0.1")!
    }
    
    var path: String {
        switch self {
        // Auth
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
            
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
        case .mypage:
            return ""
        case .changeNickname:
            return ""
        case .addStudent:
            return "/student/add"
        case .outside:
            return "/student/outing"
        case .weekStatus:
            return "/student/remained"
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
    
    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    // HTTP code가 200에서 299사이인 경우 요청이 성공한 것으로 간주된다.
    public var validationType: ValidationType {
        return .successCodes
    }
    
}