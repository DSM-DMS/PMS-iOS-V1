//
//  User.swift
//  PMS
//  존녜서영
//  Created by GoEun Jeong on 2021/03/10.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public struct Auth {
    public var email: String
    public var password: String
    public var name: String?
    
    public init(email: String, password: String, name: String? = nil) {
        self.email = email
        self.password = password
        self.name = name
    }
}

public struct accessToken: Codable {
    public var accessToken: String
    enum CodingKeys: String, CodingKey {
        case accessToken = "access-token"
    }
}
