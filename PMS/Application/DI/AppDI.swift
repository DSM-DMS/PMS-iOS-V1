//
//  AppDI.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import presentation

class AppDI: AppDIInterface {
    static let shared = AppDI()
    
    func mypageDependencies() -> MypageViewModel {
        let mypageDI = MypageDI()
        let mypageVM = mypageDI.mypageDependencies()
        return mypageVM
    }
}
