//
//  ImageService.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 25/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import UIKit
import Alamofire

class ImageService {
	
	// MARK: - Variable
	
	weak public var delegate:ImageServiceDelegate?
	
	// MARK: - Public
	
	func getImage(size:ImageRouter, releaseDate:ReleaseDate, doubleSize:Bool? = false) {
		if let hash = releaseDate.game.cover?.hash {
			self.getImage(size: size, hash: hash)
		}
		else {
			delegate?.getImageDidFail(failure: ServiceFailureType.server)
		}
	}
	
	func getImage(size:ImageRouter, hash:String, doubleSize:Bool = false) {
		size.get(hash: hash, doubleSize: doubleSize) { (response) in
			DispatchQueue.main.async {
				if let image = response.result.value {
					self.delegate?.getImageDidComplete(image: image)
				}
				else {
					debugPrint(response.result)
					self.delegate?.getImageDidFail(failure: ServiceFailureType.server)
				}
			}
		}
	}
	
}

protocol ImageServiceDelegate: class {
	func getImageDidComplete(image: UIImage)
	func getImageDidFail(failure: ServiceFailureType)
}
