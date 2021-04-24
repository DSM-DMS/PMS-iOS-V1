//
//  ViewController.swift
//  CalendarPrac
//
//  Created by jge on 2020/09/15.
//  Copyright © 2020 jge. All rights reserved.
//
import FSCalendar
import SwiftUI
import UIKit

class ViewController: UIViewController {
    @IBOutlet var calendar: FSCalendar!
    
    private var currentPage: Date?
    
    private lazy var today: Date = {
        return Date()
    }()
    
    var datesInHome = [""]
    var datesInSchool = [""]
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    @IBAction func PreviousBtnPressed(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
    }
    
    @IBAction func NextBtnPressed(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
    }
    
    private func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
        changeMonth()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendar()
        changeMonth()
        setupNotification()
    }
    
}

extension ViewController {
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getHome(_:)), name: .home, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getSchool(_:)), name: .school, object: nil)
    }
    
    @objc func getHome(_ notification: Notification) {
        let home = notification.object as! [String]
        self.datesInHome = home
        calendar.reloadData()
    }
    
    @objc func getSchool(_ notification: Notification) {
        let school = notification.object as! [String]
        self.datesInSchool = school
        calendar.reloadData()
    }
    
    func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.selectionColor = GEColor.UIblue
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.locale = Locale(identifier: "ko_KR")
        self.calendar.today = nil
    }
    
    func changeMonth() {
        let currentPageDate = calendar.currentPage
        let month = Calendar.current.component(.month, from: currentPageDate)
        NotificationCenter.default.post(name: .month, object: month)
    }
}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateString = self.dateFormatter.string(from: date)
        
        if self.datesInHome.contains(dateString) {
            return GEColor.UIred
        }
        
        if self.datesInSchool.contains(dateString) {
            return GEColor.UIgreen
        }
        
        return UIColor.white
    }
    
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        let dateString = dateFormatter.string(from: date)
//
//        if self.datesWithHolidays.contains(dateString) {
//            return .red
//        } else {
//            return nil
//        }
//    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateString = dateFormatter.string(from: date)
        NotificationCenter.default.post(name: .seletedDate, object: dateString)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        changeMonth()
    }
}
