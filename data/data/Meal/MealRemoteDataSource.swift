//
//  MealRemoteDataSource.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain
import Moya
import Combine

public protocol MealRemoteDataSourceInterface {
    func getMeal(date: Int) -> AnyPublisher<Meal, GEError>
    func getMealPicture(date: Int) -> AnyPublisher<MealPicture, GEError>
}

public class MealRemoteDataSource: MealRemoteDataSourceInterface {
    let provider: MoyaProvider<PMSApi>
    
    public init(provider: MoyaProvider<PMSApi> = MoyaProvider<PMSApi>()) {
        self.provider = provider
    }
    
    public func getMeal(date: Int) -> AnyPublisher<Meal, GEError> {
        provider.requestPublisher(.meal(date))
            .map(Meal.self)
            .mapError { error in mapGEEror(error) }
            .eraseToAnyPublisher()
    }
    
    public func getMealPicture(date: Int) -> AnyPublisher<MealPicture, GEError> {
        provider.requestPublisher(.mealPicture(date))
            .map(MealPicture.self)
            .mapError { error in mapGEEror(error) }
            .eraseToAnyPublisher()
    }
}
