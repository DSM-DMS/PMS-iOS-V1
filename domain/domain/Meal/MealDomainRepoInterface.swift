//
//  MealDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public protocol MealDomainRepoInterface {
    func getMeal(date: Int, completion : @escaping (Result<Meal, GEError>) -> Void)
    func getMealPicture(date: Int, completion: @escaping (Result<MealPicture, GEError>) -> Void)
}
