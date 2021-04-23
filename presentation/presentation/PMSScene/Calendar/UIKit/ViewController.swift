//
//  ViewController.swift
//  CalendarPrac
//
//  Created by jge on 2020/09/15.
//  Copyright © 2020 jge. All rights reserved.
//
import FSCalendar
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var calendar: FSCalendar!
    
    private var currentPage: Date?
    
    private lazy var today: Date = {
        return Date()
    }()
    
    var datesWithEvent = ["2021-04-05", "2021-04-10", "2021-04-12", "2021-04-13"]
    
    var datesWithMultipleEvents = ["2021-04-08", "2021-04-16", "2021-04-20", "2021-04-28"]
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var datesWithHolidays = ["2021-01-01", "2021-02-11", "2021-02-12", "2021-02-13", "2021-05-05", "2021-05-19", "2021-06-06", "2021-08-15", "2021-09-20", "2021-09-21", "2021-09-22", "2021-10-03", "2021-10-09", "2021-12-25", "2022-01-01", "2022-02-01", "2022-02-02", "2022-02-03", "2022-05-05", "2022-05-08", "2022-06-06", "2022-08-15", "2022-09-09", "2022-09-10", "2022-09-11", "2022-10-03", "2022-10-09", "2022-12-25", "2023-01-01", "2023-01-21", "2023-01-22", "2023-01-23", "2023-05-05", "2023-05-25", "2023-06-06", "2023-08-15", "2023-09-28", "2023-09-29", "2023-09-30", "2023-10-03", "2023-10-09", "2023-12-25"]
    
    @IBAction func PreviousBtnPressed(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
        print("preClicked")
    }
    
    @IBAction func NextBtnPressed(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
        print("nextClicked")
    }
    
    private func moveCurrentPage(moveUp: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendar.setCurrentPage(self.currentPage!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.selectionColor = UIColor(rgb: 0x5323B2)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerDateFormat = "YYYY년 M월"
        calendar.locale = Locale(identifier: "ko_KR")
        self.calendar.today = nil
    }
}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
//    private func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
//        //Do some checks and return whatever color you want to.
//        return UIColor.purple
//    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateString = self.dateFormatter2.string(from: date)
        
        if self.datesWithEvent.contains(dateString) {
            return UIColor.green
        }
        
        if self.datesWithMultipleEvents.contains(dateString) {
            return UIColor.red
        }
        
        return UIColor.white
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateString = dateFormatter2.string(from: date)
        
        if self.datesWithHolidays.contains(dateString) {
            return UIColor(rgb: GEEColor.redHex)
        } else {
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateString = dateFormatter2.string(from: date)
        
        print(dateString)
    }
    
}
