//
//  ReleaseDateApiService.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 21/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation
import Alamofire

class ReleaseDateApiService: ApiService {
	
	// MARK: - Public
    
	func get(timestamp: Int? = nil, platform:Int? = nil, order: String? = nil,
			 success: @escaping (Data) -> Void,
             failure: @escaping (ServiceFailureType) -> Void) {
        
		_ = self.sessionManager.request(
			ApiRouter.releaseDate(params: parameters(timestamp: timestamp, platform: platform, order: order)))
            .validate(statusCode: [200])
            .responseJSON { response in
				
                guard let data = response.data else {
                    failure(.connection)
                    return
                }
                
                if let error = response.error {
                    if error as? AFError == nil {
                        failure(.connection)
                    } else {
                        failure(.server)
                    }
					
                    return
                }
                
                success(data)
        }
    }
	
	// MARK: - Parameters
	
	struct APIParameterKey {
		static let fields = "fields"
		static let platform = "filter[platform][eq]"
		static let order = "order"
		static let timestamp = "filter[date][gt]"
		static let expand = "expand"
	}
	
	private func parameters(timestamp: Int? = nil, platform: Int? = nil, order: String? = nil) -> Dictionary<String, Any> {
		var params: Parameters = [APIParameterKey.fields: "*",
								   APIParameterKey.expand: "game",
								   APIParameterKey.order: "date:asc"
		]
		
		if let timestamp = timestamp {
			params[APIParameterKey.timestamp] = timestamp
		}
		
		if let platform = platform {
			params[APIParameterKey.platform] = platform
		}
		
		if let order = order {
			params[APIParameterKey.order] = order
		}
		
		return params
	}
}
