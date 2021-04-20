//
//  MypageDomainRepoInterface.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public protocol MypageDomainRepoInterface {
    func mypage(number: Int, completion: @escaping (Result<Student, GEError>) -> Void)
    func getStudent(completion: @escaping (Result<User, GEError>) -> Void)
    func changeNickname(name: String, completion: @escaping (Result<Void, GEError>) -> Void)
    func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, GEError>) -> Void)
    func addStudent(number: Int, completion: @escaping (Result<Void, GEError>) -> Void)
    func getPointList(number: Int, completion: @escaping (Result<PointList, GEError>) -> Void)
    func getOutingList(number: Int, completion: @escaping (Result<OutsideList, GEError>) -> Void)
}
