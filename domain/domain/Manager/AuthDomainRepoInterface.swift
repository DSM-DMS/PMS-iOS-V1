//
//  AuthDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public protocol AuthDomainRepoInterface {
    func refreshToken()
    func getStudent()
}
