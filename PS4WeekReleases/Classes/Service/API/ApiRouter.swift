//
//  ReleaseDateRouter.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 21/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation
import Alamofire

enum ApiRouter: URLRequestConvertible {
    
    // MARK: - Router
    
	case releaseDate(params:Parameters)
    
    // MARK: - Private
    
    private var method: HTTPMethod {
        switch self {
        case .releaseDate: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .releaseDate: return "/release_dates/"
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: ApiService.Params.baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        urlRequest.setValue("application/json", forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(Constants.APIKey, forHTTPHeaderField: HTTPHeaderField.userKey.rawValue)
        
        // Parameters
		switch self {
		case .releaseDate(let params):
			do {
				urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
			} catch {
				throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
			}
		}

        return urlRequest
    }
}
