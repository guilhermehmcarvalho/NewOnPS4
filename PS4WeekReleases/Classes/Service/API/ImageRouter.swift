//
//  ImageRouter.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 25/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire

enum ImageRouter {
	
	// MARK: - Router
	case coverBig
    case logoMed
    case thumb
	
	// MARK: - Public
	
	public func get(
        hash: String, retinaSize: RetinaSize? = nil,
        completionHandler: @escaping ((DataResponse<Image>) -> Void)) -> Request {
		
		var url: String = ApiService.Params.imageURL
		
		url.append("/t_\(self.size())")
		if retinaSize != nil { url.append("_\(retinaSize!.rawValue)") }
		url.append("/\(hash).png")
		
		return Alamofire.request(url).responseImage(completionHandler: completionHandler)
	}
	
	// MARK: - Private
	
	private func size() -> String {
        switch self {
        case .coverBig: return "cover_big"
        case .logoMed: return "logo_med"
        case .thumb: return "thumb"
        }
	}
}
