//
//  PMSUITests.swift
//  PMSUITests
//
//  Created by jge on 2020/09/30.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest

class PMSUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        
        app.activate()
        setupSnapshot(app)
        app.launch()
    }
    
    func test_A_PMS_Main_View() {
        snapshot("0Main_View")
    }
    
//    func test_login() {
//        login()
//    }
//
    func test_CalendarView() {
        if !app.buttons["일정"].exists {
            login()
        }
        
        snapshot("1Calendar_View")
        
    }
    
    func test_MealView() {
        if !app.buttons["일정"].exists {
            login()
        }
        
        app.buttons["급식"].tap()
        snapshot("2Meal_View")
        
    }
    
    func test_NoticeView() {
        if !app.buttons["일정"].exists {
            login()
        }
        
        self.app.buttons["공지"].tap()
        snapshot("3Notice_View")
    }
    
    func test_IntroduceView() {
        if !app.buttons["일정"].exists {
            login()
        }
        
        self.app.buttons["소개"].tap()
        snapshot("4Introduce_View")
        
    }
    
    func test_MypageView() {
        if !app.buttons["일정"].exists {
            login()
        }
        
        self.app.buttons["내 정보"].tap()
        snapshot("5Mypage_View")
    }
    
    func login() {
        app.buttons["로그인"].tap()
        let email = app.textFields["아이디를 입력해주세요"]
        email.tap()
        email.typeText("gogo8272@gmail.com")
        
        let secureTextField = app.secureTextFields["비밀번호를 입력해주세요"]
        secureTextField.tap()
        secureTextField.typeText("rhdms8272")
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .staticText).matching(identifier: "로그인").element(boundBy: 1).tap()
        sleep(8)
    }
    
}
