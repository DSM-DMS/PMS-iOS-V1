//
//  MealDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Combine

public protocol MealDomainRepoInterface {
    func getMeal(date: Int) -> AnyPublisher<Meal, GEError>
    func getMealPicture(date: Int) -> AnyPublisher<MealPicture, GEError>
}
