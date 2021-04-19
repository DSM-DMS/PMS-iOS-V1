//
//  MypageDomainRepoInterface.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/04/18.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public protocol MypageDomainRepoInterface {
    func mypage(number: Int, completion: @escaping (Result<Student, Error>) -> Void)
    func getStudent(completion: @escaping (Result<[User], Error>) -> Void)
    func changeNickname(name: String, completion: @escaping (Result<Void, Error>) -> Void)
    func changePassword(password: String, prePassword: String, completion: @escaping (Result<Void, Error>) -> Void)
    func addStudent(number: Int, completion: @escaping (Result<Void, Error>) -> Void)
    func getPointList(number: Int, completion: @escaping (Result<PointList, Error>) -> Void)
    func getOutingList(number: Int, completion: @escaping (Result<OutsideList, Error>) -> Void)
}
