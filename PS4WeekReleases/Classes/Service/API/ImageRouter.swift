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
	
	// MARK: - Public
	
	public func get(hash: String, doubleSize: Bool, completionHandler: @escaping ((DataResponse<Image>) -> Void)) {
		
		var url:String = ApiService.Params.imageURL
		
		url.append("/t_\(self.size())")
		if doubleSize { url.append("_2x") }
		url.append("/\(hash).png")
		
		Alamofire.request(url).responseImage(completionHandler: completionHandler)
	}
	
	// MARK: - Private
	
	private func size() -> String {
		switch self {
			case .coverBig:
			return "cover_big"
		}
	}
}
