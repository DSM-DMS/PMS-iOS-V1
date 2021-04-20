//
//  MealRemoteDataSource.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain
import Moya

public protocol MealRemoteDataSourceInterface {
    func getMeal(date: Int, completion : @escaping (Result<Meal, GEError>) -> Void)
    func getMealPicture(date: Int, completion: @escaping (Result<MealPicture, GEError>) -> Void)
}

public class MealRemoteDataSource: MealRemoteDataSourceInterface {
    let provider: MoyaProvider<PMSApi>
    
    public init(provider: MoyaProvider<PMSApi> = MoyaProvider<PMSApi>()) {
        self.provider = provider
    }
    
    public func getMeal(date: Int, completion: @escaping (Result<Meal, GEError>) -> Void) {
        provider.request(.meal(date)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let meals = try JSONDecoder().decode(Meal.self, from: responseData)
                    return completion(.success(meals))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
    public func getMealPicture(date: Int, completion: @escaping (Result<MealPicture, GEError>) -> Void) {
        provider.request(.mealPicture(date)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let meals = try JSONDecoder().decode(MealPicture.self, from: responseData)
                    return completion(.success(meals))
                } catch {
                    return completion(.failure(GEError.mappingError))
                }
            case let .failure(error):
                print(error)
                if error.asAFError?.responseCode == 401 {
                    return completion(.failure(GEError.unauthorized))
                }
                if error.asAFError?.responseCode == 404 {
                    return completion(.failure(GEError.notFound))
                }
                return completion(.failure(GEError.error))
            }
        }
    }
    
}
