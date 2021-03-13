//
//  User.swift
//  PMS
//  존녜서영
//  Created by GoEun Jeong on 2021/03/10.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

struct Auth {
    var email: String
    var password: String
    var name: String?
}

struct accessToken: Codable {
    var accessToken: String
    enum CodingKeys: String, CodingKey {
        case accessToken = "access-token"
    }
}
