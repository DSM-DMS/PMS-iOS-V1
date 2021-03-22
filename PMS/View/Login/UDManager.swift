//
//  UDManager.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/22.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation

let UD = UserDefaults.standard

class UDManager {
    static let shared = UDManager()
    
    // MARK: Views
    
    var isFirstView: Bool {
        get {
            UD.bool(forKey: "isFirstView")
        } set(value) {
            UD.set(value, forKey: "isFirstView")
        }
    }
    
    var isLogin: Bool {
        get {
            UD.bool(forKey: "isLogin")
        } set(value) {
            UD.set(value, forKey: "isLogin")
        }
    }
    
    // MARK: User
    
    var token: String? {
        get {
            UD.string(forKey: "accessToken")
        } set(value) {
            UD.set(value, forKey: "accessToken")
        }
    }
    
    var name: String? {
        get {
            UD.string(forKey: "name")
        } set(value) {
            UD.set(value, forKey: "name")
        }
    }
    
    var email: String? {
        get {
            UD.string(forKey: "email")
        } set(value) {
            UD.set(value, forKey: "email")
        }
    }
    
    var password: String? {
        get {
            UD.string(forKey: "password")
        } set(value) {
            UD.set(value, forKey: "password")
        }
    }
    
    // MARK: Student
    
    var currentStudent: String? {
        get {
            UD.string(forKey: "currentStudent")
        } set(value) {
            UD.set(value, forKey: "currentStudent")
        }
    }
    
    var studentsArray: [Any]? {
        get {
            UD.array(forKey: "studentsArray")
        } set(value) {
            UD.set(value, forKey: "studentsArray")
        }
    }
}
