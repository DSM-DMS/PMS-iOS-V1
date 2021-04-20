//
//  LoginDI.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/19.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import data
import domain
import presentation

class LoginDI {
    func loginDependencies() -> LoginViewModel {
        
        // Data Source
        let loginRemoteDataSoource = LoginRemoteDataSource()
        
        // Data Repo
        let loginDataRepo = LoginDataRepo(loginRemoteDataSource: loginRemoteDataSoource)
        
        // Domain Layer
        let loginInteractor = LoginInteractor(loginDomainRepo: loginDataRepo)
        
        // Presentation
        let loginVM = LoginViewModel(loginInteractor: loginInteractor, authDataRepo: AuthDataRepo())
        
        return loginVM
    }
    
    func signupDependencies() -> SignupViewModel {
        
        // Data Source
        let loginRemoteDataSoource = LoginRemoteDataSource()
        
        // Data Repo
        let loginDataRepo = LoginDataRepo(loginRemoteDataSource: loginRemoteDataSoource)
        
        // Domain Layer
        let loginInteractor = LoginInteractor(loginDomainRepo: loginDataRepo)
        
        // Presentation
        let signupVM = SignupViewModel(loginInteractor: loginInteractor, authDataRepo: AuthDataRepo())
        
        return signupVM
    }
}
