//
//  AuthManager.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public class AuthManager {
    public let authDataRepo: AuthDomainRepoInterface
    
    public init(authDataRepo: AuthDomainRepoInterface) {
        self.authDataRepo = authDataRepo
    }
    
    public func refreshToken() {
        authDataRepo.refreshToken()
    }
    
    public func requestStudent() {
        authDataRepo.getStudent()
    }
    
}
