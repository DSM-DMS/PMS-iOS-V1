//
//  Student.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/12.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Student: Codable {
    public var plus: Int
    public var minus: Int
    public var status: Int
    public var isMeal: Bool
    
    enum CodingKeys: String, CodingKey {
        case plus = "bonus-point"
        case minus = "minus-point"
        case status = "stay-status"
        case isMeal = "meal-applied"
    }
    
    public init(plus: Int, minus: Int, status: Int, isMeal: Bool) {
        self.plus = plus
        self.minus = minus
        self.status = status
        self.isMeal = isMeal
    }
}

public struct User: Codable {
    public var name: String
    public var students: [UsersStudent]
    
    public init(name: String, students: [UsersStudent]) {
        self.name = name
        self.students = students
    }
}

public struct UsersStudent: Codable {
    public var name: String
    public var number: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "student-name"
        case number = "student-number"
    }
    
    public init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}

public struct OutsideList: Codable {
    public var outings: [Outside]
    
    public init(outings: [Outside]) {
        self.outings = outings
    }
}

public struct Outside: Codable, Hashable {
    public var date: String
    public var place: String
    public var reason: String
    public var type: String
    
    public init(date: String, place: String, reason: String, type: String) {
        self.date = date
        self.place = place
        self.reason = reason
        self.type = type
    }
}

public struct PointList: Codable {
    public var points: [Point]
}

public struct Point: Codable, Hashable {
    public var date: String
    public var reason: String
    public var point: Int
    public var type: Bool
    
    public init(date: String, reason: String, point: Int, type: Bool) {
        self.date = date
        self.reason = reason
        self.point = point
        self.type = type
    }
}
