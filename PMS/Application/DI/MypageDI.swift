//
//  MypageDI.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import data
import domain
import presentation

class MypageDI {
    func mypageDependencies() -> MypageViewModel {
        
        // Post Data Source
        let mypageRemoteDataSource = MypageRemoteDataSource()
        let mypageLocalDataSource = MypageLocalDataSource()
        
        // Post Data Repo
        let mypageDataRepo = MypageDataRepo(mypageRemoteDataSource: mypageRemoteDataSource, mypageLocalDataSource: mypageLocalDataSource)
        
        // Domain Layer
        let mypageInteractor = MypageInteractor(mypageDomainRepo: mypageDataRepo)
        
        // Presentation
        let mypageVM = MypageViewModel(mypageInteractor: mypageInteractor)
        
        return mypageVM
    }
}
