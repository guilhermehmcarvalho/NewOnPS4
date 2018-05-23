//
//  ApiService.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 21/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    
    // MARK: - Variable
    
    let sessionManager: SessionManager = {
        let conf = URLSessionConfiguration.default
		conf.timeoutIntervalForRequest = Params.timeout
		conf.timeoutIntervalForResource = Params.timeout
        return SessionManager(configuration: conf)
    }()
    
    // MARK: - Other
    
    struct Params {
        static let baseUrl = URL(string: Bundle.main.apiBaseUrl())!
		static let timeout: Double = 15
    }
}
