//
//  PushNotificationManager.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 06/06/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation
import UserNotifications

class PushNotificationManager {
	
	// MARK: - Variables
	
	var center: UNUserNotificationCenterProtocol = UNUserNotificationCenter.current()
	let options: UNAuthorizationOptions = [.alert, .badge]
	
	// Allows injection for tests
	convenience init(notificationCenter: UNUserNotificationCenterProtocol? = nil) {
		self.init()
		
		if let notificationCenter = notificationCenter {
			self.center = notificationCenter
		}
	}
	
	var notificationContent: UNMutableNotificationContent {
		get {
			let content = UNMutableNotificationContent()
			content.title = "New this week"
			content.body = "Check out what's new on Playstation 4 this week"
			
			return content
		}
	}
	
	// MARK: - Public
	
	public func authorizeAndSchedule() {
		askForAuthorization(successHandler: {
			self.scheduleNotification()
		})
	}
	
	public func askForAuthorization(successHandler: @escaping () -> Void,
									errorHandler: (() -> Void)? = nil) {
		print("PushNotificationManager -> AskForAuthorization!")
		center.requestAuthorization(options: options) { (success, error) in
			if success {
				print("Authorization granted!")
				successHandler()
			} else {
				print("Authorization not granted")
				errorHandler?()
			}
			
			if let error = error {
				print("Error: \(error)")
			}
		}
	}
	
	public func scheduleNotification() {
		let date = DateComponents(hour: 8, minute: 00, weekday: 4)
		let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
		print(trigger.nextTriggerDate() ?? "nil")
		
		let request = UNNotificationRequest(identifier: "WeeklyNotification", content: notificationContent, trigger: trigger)
		UNUserNotificationCenter.current().add(request) { error in
			if let error = error {
				print(error)
				return
			}
			print("Scheduled!")
		}
	}
}
