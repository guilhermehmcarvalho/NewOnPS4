//
//  ReleaseDateService.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 22/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation

class ReleaseDateService: Service<ReleaseDate> {
	
	// MARK: - Variable
	
	private let apiService = ReleaseDateApiService()
	public var delegate:ReleaseDateServiceDelegate?
	
	// MARK: - Public
	
	func getPlaystationWeek() {
		let nextSundayMilliseconds = Date.today().next(.sunday).millisecondsSince1970
		let lastSundayMilliseconds = Date.today().previous(.sunday).millisecondsSince1970
		apiService.get(dateGreater: lastSundayMilliseconds, dateSmaller: nextSundayMilliseconds,
				 platform: 48,
				 order: "date:asc",
				 success: success, failure: failure)
	}
	
	// MARK: - Private
	
	private func success(data: Data) {
		DispatchQueue.main.async {
			if let releaseDates = self.jsonDecodeArray(data: data) {
				self.delegate?.getPlaystationWeekDidComplete(releaseDates: releaseDates)
			} else {
				self.delegate?.getPlaystationWeekDidComplete(failure: .server)
			}
		}
	}
	
	private func failure(_ failure: ServiceFailureType) {
		DispatchQueue.main.async {
			self.delegate?.getPlaystationWeekDidComplete(failure: failure)
		}
	}
	
}

protocol ReleaseDateServiceDelegate: class {
	func getPlaystationWeekDidComplete(releaseDates: [ReleaseDate])
	func getPlaystationWeekDidComplete(failure: ServiceFailureType)
}
