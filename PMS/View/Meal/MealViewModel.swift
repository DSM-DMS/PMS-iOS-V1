//
//  MealViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Combine

class MealViewModel: ObservableObject {
    var nows = ["아침", "점심", "저녁"]
    var changeDate = 0
    
    // MARK: Output
    @Published var today = "2020-09-21"
    @Published var getDate = "20200921"
    @Published var meals = ["", "", ""]
    @Published var pictures = ["", "", ""]
    @Published var isPicture = [false, false, false]
    
    // MARK: SetUp
    
    private var apiManager: APIManager
    private var bag = Set<AnyCancellable>()
    
    init() {
        self.apiManager = APIManager()
        bindInputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    // MARK: Input
    
    enum Input {
        case getMeal
    }
    
    private let mealSubject = PassthroughSubject<Int, Never>()
    
    func apply(_ input: Input) {
        switch input {
        case .getMeal:
            self.setDate()
            mealSubject.send(Int(self.getDate)!)
        }
    }
    
    func bindInputs() {
        mealSubject
            .compactMap { $0 }
            .sink(receiveValue: { date in
                self.requestMeal(date: date)
                self.requestMealPicture(date: date)
            })
            .store(in: &bag)
    }
    
    func setDate() {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        var dateComponent = DateComponents()
        dateComponent.day = self.changeDate
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: date)
        
        var formattedDate = format.string(from: futureDate!)
        self.today = formattedDate
        formattedDate = formattedDate.replacingOccurrences(of: "-", with: "")
        self.getDate = formattedDate
    }
    
    func changeDate(increse: Bool) {
        if increse {
            self.changeDate += 1
            setDate()
            apply(.getMeal)
        } else {
            self.changeDate -= 1
            setDate()
            apply(.getMeal)
        }
    }
}

extension MealViewModel {
    func requestMeal(date: Int) {
        apiManager.getMeal(date: date)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if error.response?.statusCode == 401 {
                        AuthManager.shared.refreshToken()
                        self.apply(.getMeal)
                    }
                    print(error)
                }
            }, receiveValue: { [weak self] meal in
                self?.meals[0] = meal.breakfast.joined(separator: "\n")
                self?.meals[1] = meal.lunch.joined(separator: "\n")
                self?.meals[2] = meal.dinner.joined(separator: "\n")
            })
            .store(in: &bag)
    }
    
    func requestMealPicture(date: Int) {
        apiManager.getMealPicture(date: date)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if error.response?.statusCode == 401 {
                        AuthManager.shared.refreshToken()
                        self.apply(.getMeal)
                    }
                    print(error)
                }
            }, receiveValue: { [weak self] meal in
                self?.pictures[0] = meal.breakfast
                self?.pictures[1] = meal.lunch
                self?.pictures[2] = meal.dinner
            })
            .store(in: &bag)
    }
}
