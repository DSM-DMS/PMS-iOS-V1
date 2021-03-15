//
//  PMSUITests.swift
//  PMSUITests
//
//  Created by jge on 2020/09/30.
//  Copyright © 2020 jge. All rights reserved.
//

import XCTest

class PMSUITests: XCTestCase {
    
    override func setUp() {
        let app = XCUIApplication()
        app.activate()
        setupSnapshot(app)
        app.launch()
    }
    
    func test_loginBtn() {
        let app = XCUIApplication()
        app.buttons["로그인"].tap()
        snapshot("0Login")
    }
    
//    func test_sample() {
//        let app = XCUIApplication()
//        app.buttons["로그인"].tap()
//
//        let textField = app.textFields["아이디를 입력해주세요"]
//        textField.tap()
//        app.buttons["shift"].tap()
//
//        app.keys["g"].tap()
//        app.keys["o"].tap()
//        app.keys["g"].tap()
//        app.keys["o"].tap()
//        app.keys["more"].tap()
//        app.keys["8"].tap()
//        app.keys["2"].tap()
//        app.keys["7"].tap()
//        app.keys["2"].tap()
//        app.keys["@"].tap()
//        app.keys["more"].tap()
//        app.keys["g"].tap()
//        app.keys["m"].tap()
//        app.keys["a"].tap()
//        app.keys["i"].tap()
//        app/*@START_MENU_TOKEN@*/.keys["l"]/*[[".keyboards.keys[\"l\"]",".keys[\"l\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.keys["more"].tap()
//        app.keys["."].tap()
//        app.keys["more"].tap()
//        app.keys["c"].tap()
//        app.keys["o"].tap()
//        app.keys["m"].tap()
//        app.secureTextFields["비밀번호를 입력해주세요"].tap()
//
//        app.keys["r"].tap()
//        app.keys["h"].tap()
//        app.keys["d"].tap()
//        app.keys["m"].tap()
//        app.keys["s"].tap()
//        app.keys["more"].tap()
//        app.keys["8"].tap()
//        app.keys["2"].tap()
//        app.keys["7"].tap()
//        app.keys["2"].tap()
//
//        app.buttons["Return"].tap()
//        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .staticText).matching(identifier: "로그인").element(boundBy: 1).tap()
//
//        snapshot("0Launch")
//    }
}
