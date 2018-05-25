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
	@IBOutlet weak var summarylabel: UILabel!
	@IBOutlet weak var imageLabel: UIImageView!
	@IBOutlet weak var activityIndicator: NVActivityIndicatorView!
	let imageService = ImageService()
	var request:Request? = nil
	
	// MARK: - UICollectionViewCell
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		imageService.delegate = self
		
		//categoryLabel.textColor = UIColor.gray
		layer.cornerRadius = 14
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.3
		layer.shadowOffset = CGSize(width: 0, height: 5)
		layer.masksToBounds = false
		
		activityIndicator.type = .pacman
	}
	
	override func prepareForReuse() {
		nameLabel.text = ""
		summarylabel.text = ""
		imageLabel.image = nil
		request?.cancel()
	}
	
	// MARK: - Public
	
	func configureWith(_ releaseDate: ReleaseDate) {
		nameLabel.text = releaseDate.game.name
		summarylabel.text = releaseDate.game.summary
		
		activityIndicator.startAnimating()
		request = imageService.getImage(size: .coverBig, releaseDate: releaseDate)
	}
}

extension ReleaseDateCell : ImageServiceDelegate {
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
