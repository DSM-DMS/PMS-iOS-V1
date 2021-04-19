//
//  Meal.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Meal: Codable, Hashable {
    public var breakfast: [String]
    public var lunch: [String]
    public var dinner: [String]
    
    public init(breakfast: [String], lunch: [String], dinner: [String]) {
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}

public struct MealPicture: Codable, Hashable {
    public var breakfast: String
    public var lunch: String
    public var dinner: String
    
    public init(breakfast: String, lunch: String, dinner: String) {
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}
