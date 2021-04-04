//
//  Meal.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

struct Meal: Codable, Hashable {
    var breakfast: [String]
    var lunch: [String]
    var dinner: [String]
}

struct MealPicture: Codable, Hashable {
    var breakfast: String
    var lunch: String
    var dinner: String
}
