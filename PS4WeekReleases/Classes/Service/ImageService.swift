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
	
	// MARK: - Variables
	
	weak public var delegate: ImageServiceDelegate?
	
	// MARK: - Public
	
	func getImage(size: ImageRouter, game: Game, retinaSize: RetinaSize? = nil) -> Request? {
		if let hash = game.cover?.hash {
            return self.getImage(size: size, hash: hash, retinaSize: retinaSize)
		} else {
			delegate?.getImageDidFail(failure: ServiceFailureType.server)
		}
		
		return nil
	}
	
	func getImage(size: ImageRouter, hash: String, retinaSize: RetinaSize? = nil) -> Request {
		return size.get(hash: hash, retinaSize: retinaSize) { (response) in
			DispatchQueue.main.async {
				if let image = response.result.value {
					self.delegate?.getImageDidComplete(image: image)
				} else {
					self.delegate?.getImageDidFail(failure: ServiceFailureType.server)
				}
			}
		}
	}
}

// MARK: - Delegate Protocol

protocol ImageServiceDelegate: class {
	func getImageDidComplete(image: UIImage)
	func getImageDidFail(failure: ServiceFailureType)
}
