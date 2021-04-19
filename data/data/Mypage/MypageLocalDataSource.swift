//
//  MypageLocalDataSource.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public protocol MypageLocalDataSourceInterface {
    func getCachedStudent(completion: @escaping (Result<Student, Error>) -> Void)
}

public class MypageLocalDataSource: MypageLocalDataSourceInterface {
    public func getCachedStudent(completion: @escaping (Result<Student, Error>) -> Void) {
        // Coredata
        // Realm
    }
}
