//
//  MealDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain

public class MealDataRepo: MealDomainRepoInterface {
    let mealRemoteDataSource: MealRemoteDataSourceInterface
    
    public init(mealRemoteDataSource: MealRemoteDataSourceInterface) {
        self.mealRemoteDataSource = mealRemoteDataSource
    }
    
    public func getMeal(date: Int, completion: @escaping (Result<Meal, GEError>) -> Void) {
        mealRemoteDataSource.getMeal(date: date) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
    
    public func getMealPicture(date: Int, completion: @escaping (Result<MealPicture, GEError>) -> Void) {
        mealRemoteDataSource.getMealPicture(date: date) { result in
            switch result {
            case let .success(success):
                return completion(.success(success))
            case let .failure(error):
                return completion(.failure(error))
            }
        }
    }
}
