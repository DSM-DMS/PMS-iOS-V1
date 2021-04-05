//
//  APIManager.swift
//  PMS
//
//  Created by GoEun Jeong on 2021/03/09.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import Combine
import Moya

class APIManager {
    let authProvider = MoyaProvider<AuthApi>()
    let pmsProvider = MoyaProvider<PMSApi>()
    
    // MARK: Auth
    
    func login(email: String, password: String) -> AnyPublisher<accessToken, MoyaError> {
        authProvider.requestPublisher(.login(email: email, password: password))
            .map(accessToken.self)
    }
    
    func regiser(email: String, password: String, name: String) -> AnyPublisher<Void, MoyaError> {
        authProvider.requestVoidPublisher(.register(email: email, password: password, name: name))
    }
    
    // MARK: Mypage
    
    func mypage(number: Int) -> AnyPublisher<Student, MoyaError> {
        authProvider.requestPublisher(.mypage(number: number))
            .map(Student.self)
    }
    
    func changeName(name: String) -> AnyPublisher<Void, MoyaError> {
        authProvider.requestVoidPublisher(.changeNickname(name: name))
    }
    
    func addStudent(number: Int) -> AnyPublisher<Void, MoyaError> {
        authProvider.requestVoidPublisher(.addStudent(number: number))
    }
    
    func getStudents() -> AnyPublisher<User, MoyaError> {
        authProvider.requestPublisher(.getStudents)
            .map(User.self)
    }
    
    func changePassword(password: String, prePassword: String) -> AnyPublisher<Void, MoyaError> {
        authProvider.requestVoidPublisher(.changePassword(password: password, prePassword: prePassword))
    }
    
    func getOutsideList(number: Int) -> AnyPublisher<OutsideList, MoyaError> {
        authProvider.requestPublisher(.outside(number: number))
            .map(OutsideList.self)
    }
    
    func getPointList(number: Int) -> AnyPublisher<PointList, MoyaError> {
        authProvider.requestPublisher(.pointList(number: number))
            .map(PointList.self)
    }
    
    func getMeal(date: Int) -> AnyPublisher<Meal, MoyaError> {
        pmsProvider.requestPublisher(.meal(date))
            .map(Meal.self)
    }
    
    func getMealPicture(date: Int) -> AnyPublisher<MealPicture, MoyaError> {
        pmsProvider.requestPublisher(.mealPicture(date))
            .map(MealPicture.self)
    }
    
    func getClubs() -> AnyPublisher<ClubList, MoyaError> {
        pmsProvider.requestPublisher(.clubs)
            .map(ClubList.self)
    }
    
    func getClubDetail(name: String) -> AnyPublisher<Club, MoyaError> {
        pmsProvider.requestPublisher(.clubDetail(name))
            .map(Club.self)
    }
    
}
