//
//  PushNotificationManagerTest.swift
//  PS4WeekReleasesTests
//
//  Created by Guilherme on 06/06/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import XCTest
@testable import PS4WeekReleases

class PushNotificationManagerTest: XCTestCase {
	
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
	func testAskForPermissionSuccessful(){
		let center = UserNotificationCenterMock()
		center.grantAuthorization = true
		let notificationManager = PushNotificationManager(notificationCenter: center)
		var success:Bool? = nil
		notificationManager.askForAuthorization (successHandler: {
			success = true
		})
		if success != nil {
			XCTAssertTrue(success!)
		}
		else {
			XCTFail()
		}
	}
	
	func testAskForPermissionUnsuccessful(){
		let center = UserNotificationCenterMock()
		center.grantAuthorization = false
		let notificationManager = PushNotificationManager(notificationCenter: center)
		var success:Bool? = nil
		notificationManager.askForAuthorization(successHandler: {
			success = true
		}) {
			success = false
		}
		
		if success != nil {
			XCTAssertFalse(success!)
		}
		else {
			XCTFail()
		}
	}
    
}
