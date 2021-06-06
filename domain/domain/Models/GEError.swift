//
//  GEError.swift
//  domain
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation

public enum GEError: Error {
    case unauthorized
    case forbidden
    case notFound
    case noInternet
    case error
}
