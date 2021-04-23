//
//  NoticeDI.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/22.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import data
import domain
import presentation

class NoticeDI {
    func noticeDependencies() -> NoticeViewModel {
        
        // Data Source
        let noticeRemoteDataSource = NoticeRemoteDataSource()
        
        // Data Repo
        let noticeDataRepo = NoticeDataRepo(noticeRemoteDataSource: noticeRemoteDataSource)
        
        // Domain Layer
        let noticeInteractor = NoticeInteractor(noticeDomainRepo: noticeDataRepo)
        
        // Presentation
        let noticeVM = NoticeViewModel(noticeInteractor: noticeInteractor, authDataRepo: AuthDataRepo())
        
        return noticeVM
    }
}
