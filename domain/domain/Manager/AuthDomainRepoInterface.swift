//
//  AuthDomainRepoInterface.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import Combine

public protocol AuthDomainRepoInterface {
    func refreshToken()
    func getStudent() -> AnyPublisher<User, GEError>
    func resetStudent()
}
