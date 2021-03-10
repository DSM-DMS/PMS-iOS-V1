//
//  AuthError.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/09.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case pwNotMatch(Error)
    case notExist(Error)
}
