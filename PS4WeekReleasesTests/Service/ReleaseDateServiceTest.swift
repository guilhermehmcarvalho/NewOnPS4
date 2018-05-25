//
//  ReleaseDateServiceTest.swift
//  PS4WeekReleasesTests
//
//  Created by Guilherme on 23/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import XCTest
@testable import PS4WeekReleases

class ReleaseDateServiceTest: APIServiceTest {
	
	let releaseDateService = ReleaseDateService()
	
	// MARK: - XCTestCase
	
    override func setUp() {
        super.setUp()
        releaseDateService.delegate = self
    }
	
	// MARK: - Test
	
	func testGetPlayestationWeek() {
		releaseDateService.getPlaystationWeek()
		waitForExpectations(timeout: ApiService.Params.timeout, handler: nil)
	}
}

extension ReleaseDateServiceTest: ReleaseDateServiceDelegate {
	
	func getPlaystationWeekDidComplete(failure: ServiceFailureType) {
		self.failure(failure)
	}
	
	func getPlaystationWeekDidComplete(releaseDates: [ReleaseDate]) {
		self.success()
	}
	
}
