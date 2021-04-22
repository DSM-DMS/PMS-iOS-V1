//
//  MypageLocalDataSource.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import domain
import Combine

public protocol MypageLocalDataSourceInterface {
    func getCachedStudent() -> AnyPublisher<Student, GEError>
}

public class MypageLocalDataSource: MypageLocalDataSourceInterface {
    
    public init() {
        
    }
    
    public func getCachedStudent() -> AnyPublisher<Student, GEError> {
        // Coredata
        // Realm
        return Just(Student(plus: 0, minus: 0, status: 0, isMeal: true))
            .setFailureType(to: GEError.self)
            .eraseToAnyPublisher()
    }
}
