//
//  Student.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/12.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

struct Student: Codable {
    var plus: Int
    var minus: Int
    var status: Int
    var isMeal: Bool
    
    enum CodingKeys: String, CodingKey {
        case plus = "bonus-point"
        case minus = "minus-point"
        case status = "stay-status"
        case isMeal = "meal-applied"
    }
}

struct User: Codable {
    var name: String
    var students: [UsersStudent]
}

struct UsersStudent: Codable {
    var name: String
    var number: Int
}
