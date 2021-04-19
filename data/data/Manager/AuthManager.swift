//
//  AuthManager.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/22.
//  Copyright © 2021 jge. All rights reserved.
//

import Combine
import Foundation

class AuthManager {
    static let shared = AuthManager()
//    let apiManager = APIManager()
    private var bag = Set<AnyCancellable>()
    
    func refreshToken() {
//        apiManager.login(email: UDManager.shared.email!, password: UDManager.shared.password!)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                if case .failure(let error) = completion {
//                    if error.response?.statusCode == 401 {
//                        print("the email & password not match")
//                    } else if error.errorCode == 6 {
//                        print("you're not in internet")
//                    }
//                    print(error)
//                }
//            }, receiveValue: { token in
//                UDManager.shared.token = token.accessToken
//            })
//            .store(in: &bag)
    }
    
    func requestStudent() {
//        apiManager.getStudents()
//            .receive(on: DispatchQueue.main)
//            .retry(2)
//            .sink(receiveCompletion: { completion in
//                if case .failure(let error) = completion {
//                    if error.response?.statusCode == 401 {
//                        AuthManager.shared.refreshToken()
//                    }
//                    print(error)
//                }
//            }, receiveValue: { user in
//                UDManager.shared.name = user.name
//                if !user.students.isEmpty {
//                    let firstuser: String = String(user.students.first!.number) + " " + user.students.first!.name
//                    UDManager.shared.currentStudent = firstuser
//                    print(firstuser)
//                    var studentsArray = [String]()
//                    for i in 0...user.students.count - 1 {
//                        studentsArray.append(String((user.students[i].number)) + " " + (user.students[i].name))
//                    }
//                    if !studentsArray.isEmpty {
//                        print(studentsArray)
//                        UDManager.shared.studentsArray = studentsArray
//                    }
//                }
//            })
//            .store(in: &bag)
    }
    
}
