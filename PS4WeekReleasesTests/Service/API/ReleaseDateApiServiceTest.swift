//
//  ReleaseDateApiServiceTest.swift
//  PS4WeekReleasesTests
//
//  Created by Guilherme on 23/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import XCTest
@testable import PS4WeekReleases

class ReleaseDateApiServiceTest: APIServiceTest {
	
	private let service = ReleaseDateApiService()
	
	// MARK: - XCTestCase
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
	
	// MARK: - Test
	
	func testGetReleaseDates() {
		self.get()
	}
    
	// MARK: - Private
	
	private func get(dateGreater: Double? = nil, dateSmaller: Double? = nil) {
		service.get(dateGreater: dateGreater, dateSmaller: dateSmaller,
		success: { data, _, _ in
			do {
				_ = try JSONDecoder().decode([ReleaseDate].self, from: data)
				self.success()
			} catch let error {
                print("Parse error: \(error)")
				self.failure(.server)
			}
		}, failure: { failure in
			self.failure(failure)
		})
		
		waitForExpectations(timeout: ApiService.Params.timeout, handler: nil)
	}
    
}
