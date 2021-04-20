//
//  MealDI.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/19.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import data
import domain
import presentation

class MealDI {
    func mealDependencies() -> MealViewModel {
        
        // Data Source
        let mealRemoteDataSource = MealRemoteDataSource()
        
        // Data Repo
        let mealDataRepo = MealDataRepo(mealRemoteDataSource: mealRemoteDataSource)
        
        // Domain Layer
        let mealInteractor = MealInteractor(mealDomainRepo: mealDataRepo)
        
        // Presentation
        let mealVM = MealViewModel(mealInteractor: mealInteractor, authDataRepo: AuthDataRepo())
        
        return mealVM
    }
}
