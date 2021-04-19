//
//  AppDIInterface.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public protocol AppDIInterface {
    func mypageDependencies() -> MypageViewModel
//    func beerDetailsDependencies() -> MealViewModel
}
