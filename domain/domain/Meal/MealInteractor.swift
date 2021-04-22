//
//  MealInteractor.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import Combine

public protocol MealInteractorInterface {
    func getMeal(date: Int) -> AnyPublisher<Meal, GEError>
    func getMealPicture(date: Int) -> AnyPublisher<MealPicture, GEError>
}

public class MealInteractor: MealInteractorInterface {
    let mealDomainRepo: MealDomainRepoInterface
    
    public init(mealDomainRepo: MealDomainRepoInterface) {
        self.mealDomainRepo = mealDomainRepo
    }
    
    public func getMeal(date: Int) -> AnyPublisher<Meal, GEError> {
        return mealDomainRepo.getMeal(date: date)
    }
    
    public func getMealPicture(date: Int) -> AnyPublisher<MealPicture, GEError> {
        return mealDomainRepo.getMealPicture(date: date)
    }
}
