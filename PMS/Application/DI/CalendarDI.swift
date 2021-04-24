//
//  CalendarDI.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/23.
//  Copyright © 2021 jge. All rights reserved.
//
import Foundation
import data
import domain
import presentation

class CalendarDI {
    func calendarDependencies() -> CalendarViewModel {
        // Data Repo
        let calendarDataRepo = CalendarDataRepo()
        
        // Domain Layer
        let calendarInteractor = CalendarInteractor(calendarDomainRepo: calendarDataRepo)
        
        // Presentation
        let calendarVM = CalendarViewModel(calendarInteractor: calendarInteractor, authDataRepo: AuthDataRepo())
        
        return calendarVM
    }
}
