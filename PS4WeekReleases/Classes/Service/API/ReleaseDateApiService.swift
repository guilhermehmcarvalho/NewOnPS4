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
    
    func get(success: @escaping (Data) -> Void,
             failure: @escaping (ServiceFailureType) -> Void) {
        
        _ = self.sessionManager.request(ReleaseDateApiRouter.get())
            //.validate(statusCode: [200])
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
}
