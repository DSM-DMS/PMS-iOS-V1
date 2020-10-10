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

    func test_sample() {
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
