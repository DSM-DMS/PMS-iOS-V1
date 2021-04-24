//
//  CalendarViewModel.swift
//  presentation
//
//  Created by GoEun Jeong on 2021/04/23.
//

import Foundation
import SwiftUI
import Combine
import domain

extension Notification.Name {
    public static let seletedDate = Notification.Name(rawValue: "seletedDate")
    public static let month = Notification.Name(rawValue: "month")
    public static let home = Notification.Name(rawValue: "home")
    public static let school = Notification.Name(rawValue: "school")
}

public class CalendarViewModel: ObservableObject {
    // MARK: Output
    var calendar = PMSCalendar()
    @Published var datesInHome = [String]()
    @Published var datesInSchool = [String]()
    @Published var month = 0
    @Published var selectedDate = ""
    @Published var detailCalendar = [String]()

    private var bag = Set<AnyCancellable>()

    private var calendarInteractor: CalendarInteractorInterface
    private var authDataRepo: AuthDomainRepoInterface

    public init(calendarInteractor: CalendarInteractorInterface, authDataRepo: AuthDomainRepoInterface) {
        self.calendarInteractor = calendarInteractor
        self.authDataRepo = authDataRepo
        bindInputs()
        bindOutputs()
        setupNotification()
    }

    deinit {
        bag.removeAll()
    }

    // MARK: Input

    enum Input {
        case onAppear
    }

    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let getDetailCalendarSubject = PassthroughSubject<String, Never>()
    private let monthSubject = PassthroughSubject<Int, Never>()
    private let calendarSubject = PassthroughSubject<[String: [String: [String]]], Never>()
    private let dateHomeSubject = PassthroughSubject<[String], Never>()
    private let detailCalendarSubject = PassthroughSubject<String, Never>()

    func apply(_ input: Input) {
        switch input {
        case .onAppear:
            self.month = Calendar.current.component(.month, from: Date())
            onAppearSubject.send(())
        }
    }

    func bindInputs() {
        onAppearSubject
            .flatMap { [calendarInteractor] _ in
                calendarInteractor.getCalendar()
                    .catch { [weak self] error -> Empty<PMSCalendar, Never> in
                        print(error)
                        if error == GEError.unauthorized {
                            self?.authDataRepo.refreshToken()
                            self?.apply(.onAppear)
                        }
                        return .init()
                    }
            }
            .share()
            .subscribe(calendarSubject)
            .store(in: &bag)

        monthSubject
            .sink(receiveValue: { month in
                for (key, value) in self.calendar {
                    if key == String(month) {
                        for (key, value) in value {
                            if value.contains("의무귀가") {
                                self.datesInHome.append(key)
                            } else if !value.contains("빙학") || !value.contains("토요휴업일") {
                                self.datesInSchool.append(key)
                            }
                        }
                    }
                }
                if self.datesInHome != [] {
                    NotificationCenter.default.post(name: .home, object: self.datesInHome)
                }
                NotificationCenter.default.post(name: .school, object: self.datesInSchool)
            })
            .store(in: &bag)

        getDetailCalendarSubject
            .sink(receiveValue: { date in
                for (key, value) in self.calendar {
                    if key == String(self.month) {
                        for (key, value) in value {
                            if self.datesInHome.contains(date) && date == key {
                                self.detailCalendar = value
                            } else if self.datesInSchool.contains(date) && date == key {
                                self.detailCalendar = value
                            }
                        }
                    }
                }
            })
            .store(in: &bag)
    }

    func bindOutputs() {
        calendarSubject
            .sink(receiveValue: { calendar in
                self.calendar = calendar
                self.monthSubject.send(self.month)
            })
            .store(in: &bag)
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getMonth(_:)), name: .month, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getDetail(_:)), name: .seletedDate, object: nil)
    }
    
    @objc func getMonth(_ notification: Notification) {
        let month = notification.object as! Int
        self.month = month
        self.monthSubject.send(month)
    }
    
    @objc func getDetail(_ notification: Notification) {
        let date = notification.object as! String
        self.getDetailCalendarSubject.send(date)
        self.selectedDate = date
    }

}
