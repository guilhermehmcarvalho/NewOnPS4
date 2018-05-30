//
//  ReleaseDateCell.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 25/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import NVActivityIndicatorView

class ReleaseDateCell: UICollectionViewCell {
	
	// MARK: - Variables
    
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var imageLabel: UIImageView!
	@IBOutlet weak var activityIndicator: NVActivityIndicatorView!
	let imageService = ImageService()
	var request: Request?
	
	// MARK: - UIReleaseDateCell
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		imageService.delegate = self
		
		layer.cornerRadius = 14
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.3
		layer.shadowOffset = CGSize(width: 0, height: 5)
		layer.masksToBounds = false
        layer.backgroundColor = UIColor.App.black.cgColor
		
		activityIndicator.type = .pacman
        activityIndicator.color = UIColor.App.yellow
	}
	
	override func prepareForReuse() {
		nameLabel.text = ""
		//summarylabel.text = ""
		imageLabel.image = nil
		request?.cancel()
	}
	
	// MARK: - Public
	
	func configureWith(_ game: Game) {
		nameLabel.text = game.name
		
		activityIndicator.startAnimating()
        request = imageService.getImage(size: .coverBig, game: game, retinaSize: RetinaSize.retina2x)
	}
}

// MARK: - ImageServiceDelegate

extension ReleaseDateCell: ImageServiceDelegate {
	func getImageDidComplete(image: UIImage) {
		imageLabel.image = image
		activityIndicator.stopAnimating()
	}
	
	func getImageDidFail(failure: ServiceFailureType) {
		imageLabel.image = nil
		activityIndicator.stopAnimating()
		activityIndicator.isHidden = true
	}
}
