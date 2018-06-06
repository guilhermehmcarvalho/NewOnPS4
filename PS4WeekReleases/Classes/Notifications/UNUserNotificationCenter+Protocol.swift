//
//  UNUserNotificationCenter+Protocol.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 06/06/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation
import UserNotifications

// Used for mocking UNUserNotificationCenter
extension UNUserNotificationCenter: UNUserNotificationCenterProtocol {}

protocol UNUserNotificationCenterProtocol {
	func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
}
