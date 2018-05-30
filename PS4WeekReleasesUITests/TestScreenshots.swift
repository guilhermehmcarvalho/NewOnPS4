//
//  TestScreenshots.swift
//  PS4WeekReleasesUITests
//
//  Created by Guilherme Carvalho on 29/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import XCTest

class TestScreenshots: XCTestCase {
        
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    // MARK: - Test
    
    func testSnapshot0() {
        snapshot("0Launch")
    }
    
}
