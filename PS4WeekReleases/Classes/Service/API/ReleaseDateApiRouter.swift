//
//  ReleaseDateRouter.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 21/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation
import Alamofire

enum ReleaseDateApiRouter: URLRequestConvertible {
    
    // MARK: - Router
    
    case get()
    
    // MARK: - Private
    
    private var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    private var path: String {
        switch self {
        case .get: return "/release_dates/"
        }
    }
    
    // MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: ApiService.Params.baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        // Headers
        urlRequest.setValue("application/json", forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        //TODO: put key somewhere else
        urlRequest.setValue("1a79e2af1773ef1d63fa0af63ba2c596", forHTTPHeaderField: HTTPHeaderField.userKey.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }

    // MARK: - Parameters
    
    struct APIParameterKey {
        static let fields = "fields"
        static let platform = "filter[platform][eq]"
        static let order = "order"
        static let filter = "filter[date][gt]"
        static let expand = "expand"
    }
    
    private var parameters: Parameters? {
        let params: Parameters? = [APIParameterKey.fields: "*",
         APIParameterKey.platform: 48,
         APIParameterKey.order: "date:asc",
         APIParameterKey.filter: Date().millisecondsSince1970,
         APIParameterKey.expand: "game"
        ]
        
        switch self {
        /*case .get(timestamp:Int):
            params[APIParameterKey.filter] = timestamp
            return params*/
        case .get():
            return params
        }
        
    }
    
}
