//
//  Service.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 21/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation

class Service<T: Decodable> {
    
    // MARK: - Public
    
    func jsonDecode(data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
			print("Error @ Service/jsonDecode: \(error)")
            return nil
        }
    }
	
	func jsonDecodeArray(data: Data) -> [T]? {
		do {
			return try JSONDecoder().decode([T].self, from: data)
		} catch let error {
			print("Error @ Service/jsonDecodeArray: \(error)")
			return nil
		}
	}
    
}

// MARK: - Others

enum ServiceFailureType {
    case connection
    case server
}
