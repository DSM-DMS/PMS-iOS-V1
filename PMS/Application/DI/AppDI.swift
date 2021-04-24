//
//  AppDI.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import presentation
import data
import domain

class AppDI: AppDIInterface {
    static let shared = AppDI()
    
    func mypageDependencies() -> MypageViewModel {
        let mypageDI = MypageDI()
        let mypageVM = mypageDI.mypageDependencies()
        return mypageVM
    }
    
    func loginDependencies() -> LoginViewModel {
        let loginDI = LoginDI()
        let loginVM = loginDI.loginDependencies()
        return loginVM
    }
    
    func signupDependencies() -> SignupViewModel {
        let loginDI = LoginDI()
        let signupVM = loginDI.signupDependencies()
        return signupVM
    }
    
    func mealDependencies() -> MealViewModel {
        let mealDI = MealDI()
        let mealVM = mealDI.mealDependencies()
        return mealVM
    }
    
    func introduceDependencies() -> IntroduceViewModel {
        let introduceDI = IntroduceDI()
        let introduceVM = introduceDI.introduceDependencies()
        return introduceVM
    }
    
    func noticeDependencies() -> NoticeViewModel {
        let noticeDI = NoticeDI()
        let noticeVM = noticeDI.noticeDependencies()
        return noticeVM
    }
    
    func calendarDependencies() -> CalendarViewModel {
        let calendarDI = CalendarDI()
        let calendarVM = calendarDI.calendarDependencies()
        return calendarVM
    }
    
    func authDataRepo() -> AuthDomainRepoInterface {
        AuthDataRepo()
    }
}
