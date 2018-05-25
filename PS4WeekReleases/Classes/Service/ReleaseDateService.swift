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
	private let dataCache = WeekSearchStoreManager()
	weak public var delegate: ReleaseDateServiceDelegate?
	
	// MARK: - Public
	
	func getPlaystationWeek() {
		let nextSundayMilliseconds = Date.today().next(.wednesday).millisecondsSince1970
		let lastSundayMilliseconds = Date.today().previous(.wednesday).millisecondsSince1970

        if let fetchedData = dbFetch(dateGreater: lastSundayMilliseconds, dateSmaller: nextSundayMilliseconds) {
            DispatchQueue.main.async {
                self.delegate?.getPlaystationWeekDidComplete(releaseDates: fetchedData)
            }
            return
        }
		
		apiService.get(dateGreater: lastSundayMilliseconds, dateSmaller: nextSundayMilliseconds,
				 platform: Platform.playstation4,
				 order: "date:asc",
				 success: success, failure: failure)
	}
	
	// MARK: - Private
	
	private func success(data: Data, dateGreater: Double?, dateSmaller: Double?) {
		DispatchQueue.main.async {
			if let releaseDates = self.jsonDecodeArray(data: data) {
				self.delegate?.getPlaystationWeekDidComplete(releaseDates: releaseDates)
				if dateGreater != nil && dateSmaller != nil {
					self.dbInsert(dateGreater: dateGreater!, dateSmaller: dateSmaller!, data: data)
				}
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
	
	// MARK: - Core data
	
	func dbFetch(dateGreater: Double, dateSmaller: Double) -> [ReleaseDate]? {
		guard let request = dataCache.fetch(dateGreater: dateGreater, dateSmaller: dateSmaller) else { return nil }
		
		if let data = request.data {
			return jsonDecodeArray(data: data)
		}
		
		return nil
	}
	
	func dbInsert(dateGreater: Double, dateSmaller: Double, data: Data) {
		dataCache.insertReleaseDate(dateGreater: dateGreater, dateSmaller: dateSmaller, data: data)
	}
	
}

protocol ReleaseDateServiceDelegate: class {
	func getPlaystationWeekDidComplete(releaseDates: [ReleaseDate])
	func getPlaystationWeekDidComplete(failure: ServiceFailureType)
}
