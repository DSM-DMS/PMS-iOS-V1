//
//  AuthDataRepo.swift
//  data
//
//  Created by GoEun Jeong on 2021/04/19.
//

import Foundation
import domain
import Moya

public class AuthDataRepo: AuthDomainRepoInterface {
    let provider = MoyaProvider<AuthApi>()
    
    public init() {}
    
    public func refreshToken() {
        provider.request(.login(email: UDManager.shared.email!, password: UDManager.shared.password!)) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let token = try JSONDecoder().decode(accessToken.self, from: responseData)
                    UDManager.shared.token = token.accessToken
                } catch {
                    print("map error")
                }
            case let .failure(error):
                if error.response?.statusCode == 401 {
                    print("the email & password not match")
                } else if error.errorCode == 6 {
                    print("you're not in internet")
                }
                print(error)
            }
        }
    }
    
    public func getStudent() {
        provider.request(.getStudents) { result in
            switch result {
            case let .success(success):
                let responseData = success.data
                do {
                    let user = try JSONDecoder().decode(User.self, from: responseData)
                    UDManager.shared.name = user.name
                    if !user.students.isEmpty {
                        let firstuser: String = String(user.students.first!.number) + " " + user.students.first!.name
                        UDManager.shared.currentStudent = firstuser
                        print(firstuser)
                        var studentsArray = [String]()
                        for i in 0...user.students.count - 1 {
                            studentsArray.append(String((user.students[i].number)) + " " + (user.students[i].name))
                        }
                        if !studentsArray.isEmpty {
                            print(studentsArray)
                            UDManager.shared.studentsArray = studentsArray
                        }
                    }
                } catch {
                    print("map error")
                }
            case let .failure(error):
                if error.response?.statusCode == 401 {
                    self.refreshToken()
                } else if error.errorCode == 6 {
                    print("you're not in internet")
                }
                print(error)
            }
        }
    }
}
