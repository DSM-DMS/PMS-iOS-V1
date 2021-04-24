//
//  CalendarInteractor.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/23.
//

import Foundation
import Combine

public protocol CalendarInteractorInterface {
    func getCalendar() -> AnyPublisher<PMSCalendar, GEError>
}

public class CalendarInteractor: CalendarInteractorInterface {
    let calendarDomainRepo: CalendarInteractorInterface
    
    public init(calendarDomainRepo: CalendarInteractorInterface) {
        self.calendarDomainRepo = calendarDomainRepo
    }
    
    public func getCalendar() -> AnyPublisher<PMSCalendar, GEError> {
        self.calendarDomainRepo.getCalendar()
    }
}
