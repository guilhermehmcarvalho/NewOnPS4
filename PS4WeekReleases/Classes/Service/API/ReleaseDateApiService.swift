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
    
	func get(dateGreater: Double? = nil, dateSmaller: Double? = nil, platform:Int? = nil, order: String? = nil,
             success: @escaping (Data, _ dateGreater: Double?, _ dateSmaller: Double?) -> Void,
             failure: @escaping (ServiceFailureType) -> Void) {
        
		_ = self.sessionManager.request(
			ApiRouter.releaseDate(params: parameters(dateGreater: dateGreater, dateSmaller: dateSmaller,
													 platform: platform, order: order)))
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
                
                success(data, dateGreater, dateSmaller)
        }
    }
	
	// MARK: - Parameters
	
	struct APIParameterKey {
		static let fields = "fields"
		static let platform = "filter[platform][eq]"
		static let order = "order"
		static let dateGreater = "filter[date][gte]"
		static let dateSmaller = "filter[date][lt]"
		static let expand = "expand"
	}
	
	private func parameters(dateGreater: Double? = nil,
                            dateSmaller: Double? = nil,
                            platform: Int? = nil,
                            order: String? = nil) -> Dictionary<String, Any> {
		var params: Parameters = [APIParameterKey.fields: "*",
								   APIParameterKey.expand: "game",
								   APIParameterKey.order: "date:asc"
		]
		
		if let dateGreater = dateGreater {
			params[APIParameterKey.dateGreater] = dateGreater
		}
		
		if let dateSmaller = dateSmaller {
			params[APIParameterKey.dateSmaller] = dateSmaller
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
