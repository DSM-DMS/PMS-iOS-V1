//
//  MealInteractor.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public protocol MealInteractorInterface {
    func getMeal(date: Int, completion : @escaping (Result<Meal, GEError>) -> Void)
    func getMealPicture(date: Int, completion: @escaping (Result<MealPicture, GEError>) -> Void)
}

public class MealInteractor: MealInteractorInterface {
    let mealDomainRepo: MealDomainRepoInterface
    
    public init(mealDomainRepo: MealDomainRepoInterface) {
        self.mealDomainRepo = mealDomainRepo
    }
    
    public func getMeal(date: Int, completion: @escaping (Result<Meal, GEError>) -> Void) {
        mealDomainRepo.getMeal(date: date) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getMealPicture(date: Int, completion: @escaping (Result<MealPicture, GEError>) -> Void) {
        mealDomainRepo.getMealPicture(date: date) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
}
