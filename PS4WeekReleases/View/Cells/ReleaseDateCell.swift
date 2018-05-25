//
//  ReleaseDateCell.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 25/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import UIKit

class ReleaseDateCell: UICollectionViewCell {
    
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var summarylabel: UILabel!
	@IBOutlet weak var imageLabel: UIImageView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		//categoryLabel.textColor = UIColor.gray
		layer.cornerRadius = 14
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.3
		layer.shadowOffset = CGSize(width: 0, height: 5)
		layer.masksToBounds = false
	}
	
	func configureWith(_ releaseDate: ReleaseDate) {
		nameLabel.text = releaseDate.game.name
		summarylabel.text = releaseDate.game.summary
	}
}
