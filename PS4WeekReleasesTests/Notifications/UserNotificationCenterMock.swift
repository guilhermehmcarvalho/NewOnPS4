//
//  UserNotificationCenterMock.swift
//  PS4WeekReleasesTests
//
//  Created by Guilherme on 06/06/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation
import UserNotifications
@testable import PS4WeekReleases

class UserNotificationCenterMock: UNUserNotificationCenterProtocol {
	
	var grantAuthorization = false
	var error: Error?
	
	func requestAuthorization(options: UNAuthorizationOptions,
							  completionHandler: @escaping (Bool, Error?) -> Void) {
		completionHandler(grantAuthorization, error)
	}
}
