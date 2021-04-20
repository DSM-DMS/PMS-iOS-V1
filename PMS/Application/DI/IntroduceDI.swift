//
//  IntroduceDI.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/19.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import data
import domain
import presentation

class IntroduceDI {
    func introduceDependencies() -> IntroduceViewModel {
        
        // Data Source
        let introduceRemoteDataSource = IntroduceRemoteDataSource()
        
        // Data Repo
        let introduceDataRepo = IntroduceDataRepo(introduceRemoteDataSource: introduceRemoteDataSource)
        
        // Domain Layer
        let introduceInteractor = IntroduceInteractor(introduceDomainRepo: introduceDataRepo)
        
        // Presentation
        let introduceVM = IntroduceViewModel(introduceInteractor: introduceInteractor, authDataRepo: AuthDataRepo())
        
        return introduceVM
    }
}
