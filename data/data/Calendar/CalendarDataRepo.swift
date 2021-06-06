//
//  CalendarDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/23.
//

import Foundation
import domain
import Combine
import Moya

public class CalendarDataRepo: CalendarInteractorInterface {
    let provider = MoyaProvider<PMSApi>()
    public func getCalendar() -> AnyPublisher<PMSCalendar, GEError> {
        provider.requestPublisher(.calendar)
            .map(PMSCalendar.self)
            .mapError { error in
                mapGEEror(error)
            }
//            .catch { _ in
//                return self.getLocalCalendar()
//            }
            .eraseToAnyPublisher()
    }
    
    private func getLocalCalendar() -> AnyPublisher<PMSCalendar, GEError> {
        return Just(PMSCalendar())
            .setFailureType(to: GEError.self)
            .eraseToAnyPublisher()
    }
    
    public init() {}
}
