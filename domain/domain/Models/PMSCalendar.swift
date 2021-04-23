//
//  Calendar.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/22.
//

import Foundation

public struct PMSCalendar {
    var one: [[String: [String]]]?
    var two: [[String: [String]]]?
    var three: [[String: [String]]]?
    var four: [[String: [String]]]?
    var five: [[String: [String]]]?
    var six: [[String: [String]]]?
    var seven: [[String: [String]]]?
    var eight: [[String: [String]]]?
    var nine: [[String: [String]]]?
    var ten: [[String: [String]]]?
    var eleven: [[String: [String]]]?
    var twelve: [[String: [String]]]?
    
    enum CodingKeys: String, CodingKey {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case eleven = "11"
        case twelve = "12"
    }
}
