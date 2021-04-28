//
//  UDManager.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/22.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

public let UD = UserDefaults.standard

public class UDManager {
    public static let shared = UDManager()
    
    // MARK: Views
    
    public var isFirstView: Bool {
        get {
            UD.bool(forKey: "isFirstView")
        } set(value) {
            UD.set(value, forKey: "isFirstView")
        }
    }
    
    public var isLogin: Bool {
        get {
            UD.bool(forKey: "isLogin")
        } set(value) {
            UD.set(value, forKey: "isLogin")
        }
    }
    
    // MARK: User
    
    public var token: String? {
        get {
            return UD.string(forKey: "accessToken")
        } set(value) {
            UD.set(value, forKey: "accessToken")
        }
    }
    
    public var name: String? {
        get {
            UD.string(forKey: "name")
        } set(value) {
            UD.set(value, forKey: "name")
        }
    }
    
    public var email: String? {
        get {
            UD.string(forKey: "email")
        } set(value) {
            UD.set(value, forKey: "email")
        }
    }
    
    public var password: String? {
        get {
            UD.string(forKey: "password")
        } set(value) {
            UD.set(value, forKey: "password")
        }
    }
    
    // MARK: Student
    
    public var currentStudent: String? {
        get {
            UD.string(forKey: "currentStudent")
        } set(value) {
            UD.set(value, forKey: "currentStudent")
        }
    }
}
