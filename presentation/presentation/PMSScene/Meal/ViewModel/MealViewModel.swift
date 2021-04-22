//
//  MealViewModel.swift
//  PMS
//
//  Created by jge on 2020/10/05.
//  Copyright © 2020 jge. All rights reserved.
//

import Foundation
import Combine
import domain

public class MealViewModel: ObservableObject {
    var nows = ["아침", "점심", "저녁"]
    var changeDate = 0
    
    // MARK: Output
    @Published var today = "2020-09-21"
    @Published var getDate = "20200921"
    @Published var meals = ["", "", ""]
    @Published var pictures = ["", "", ""]
    @Published var isPicture = [false, false, false]
    
    // MARK: SetUp
    
    private var bag = Set<AnyCancellable>()
    
    private var mealInteractor: MealInteractorInterface
    private var authDataRepo: AuthDomainRepoInterface
    
    public init(mealInteractor: MealInteractorInterface, authDataRepo: AuthDomainRepoInterface) {
        self.mealInteractor = mealInteractor
        self.authDataRepo = authDataRepo
        bindInputs()
        bindOutputs()
    }
    
    deinit {
        bag.removeAll()
    }
    
    // MARK: Input
    
    enum Input {
        case getMeal
    }
    
    private let getMealSubject = PassthroughSubject<Int, Never>()
    private let mealSubject = PassthroughSubject<Meal, Never>()
    private let mealPictureSubject = PassthroughSubject<MealPicture, Never>()
    private let errorSubject = PassthroughSubject<GEError, Never>()
    
    func apply(_ input: Input) {
        switch input {
        case .getMeal:
            self.setDate()
            getMealSubject.send(Int(self.getDate)!)
        }
    }
    
    func bindInputs() {
        getMealSubject
            .flatMap { [mealInteractor] date in
                mealInteractor.getMeal(date: date)
                    .catch { [weak self] error -> Empty<Meal, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(mealSubject)
            .store(in: &bag)
            
        getMealSubject
            .flatMap { [mealInteractor] date in
                mealInteractor.getMealPicture(date: date)
                    .catch { [weak self] error -> Empty<MealPicture, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(mealPictureSubject)
            .store(in: &bag)
    }
    
    func bindOutputs() {
        mealSubject
            .sink(receiveValue: {[weak self] meal in
                self?.meals[0] = meal.breakfast.joined(separator: "\n")
                self?.meals[1] = meal.lunch.joined(separator: "\n")
                self?.meals[2] = meal.dinner.joined(separator: "\n")
            })
            .store(in: &bag)
        
        mealPictureSubject
            .sink(receiveValue: {[weak self] meal in
                self?.pictures[0] = meal.breakfast
                self?.pictures[1] = meal.lunch
                self?.pictures[2] = meal.dinner
            })
            .store(in: &bag)
        
        errorSubject
            .sink(receiveValue: { [weak self] error in
                if error == .unauthorized {
                    self?.authDataRepo.refreshToken()
                    self?.apply(.getMeal)
                }
            })
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
