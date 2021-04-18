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
    
    var datesWithEvent = ["2020-09-09", "2020-09-10", "2020-09-12", "2020-09-13"]
    
    var datesWithMultipleEvents = ["2020-10-08", "2020-09-16", "2020-09-20", "2020-09-28"]
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var datesWithHolidays = ["2020-09-09", "2020-09-18"]
    
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
        self.calendar.today = nil
    }
}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        let dateString = self.dateFormatter2.string(from: date)
        
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        
        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }
        
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateString = dateFormatter2.string(from: date)

        if self.datesWithHolidays.contains(dateString) {
            return .red
        } else {
            return nil
        }
    }
    
}
