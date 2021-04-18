//
//  Student.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/12.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Student: Codable {
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

public struct User: Codable {
    var name: String
    var students: [UsersStudent]
}

public struct UsersStudent: Codable {
    var name: String
    var number: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "student-name"
        case number = "student-number"
    }
}

public struct OutsideList: Codable {
    var outings: [Outside]
}

public struct Outside: Codable, Hashable {
    var date: String
    var place: String
    var reason: String
    var type: String
}

public struct PointList: Codable {
    var points: [Point]
}

public struct Point: Codable, Hashable {
    var date: String
    var reason: String
    var point: Int
    var type: Bool
}
