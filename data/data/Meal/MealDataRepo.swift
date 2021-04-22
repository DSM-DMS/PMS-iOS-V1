//
//  MealDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain
import Combine

public class MealDataRepo: MealDomainRepoInterface {
    let mealRemoteDataSource: MealRemoteDataSourceInterface
    
    public init(mealRemoteDataSource: MealRemoteDataSourceInterface) {
        self.mealRemoteDataSource = mealRemoteDataSource
    }
    public func getMeal(date: Int) -> AnyPublisher<Meal, GEError> {
        mealRemoteDataSource.getMeal(date: date)
    }
    public func getMealPicture(date: Int) -> AnyPublisher<MealPicture, GEError> {
        mealRemoteDataSource.getMealPicture(date: date)
    }
}
