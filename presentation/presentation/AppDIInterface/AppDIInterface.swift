//
//  AppDIInterface.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import domain

public protocol AppDIInterface {
    func mypageDependencies() -> MypageViewModel
    func loginDependencies() -> LoginViewModel
    func signupDependencies() -> SignupViewModel
    func mealDependencies() -> MealViewModel
    func introduceDependencies() -> IntroduceViewModel
    func noticeDependencies() -> NoticeViewModel
    func calendarDependencies() -> CalendarViewModel
    
    func authDataRepo() -> AuthDomainRepoInterface
}
