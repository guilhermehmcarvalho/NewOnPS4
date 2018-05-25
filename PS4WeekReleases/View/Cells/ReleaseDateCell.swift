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
	
	func configureWith(_ releaseDate: ReleaseDate) {
		nameLabel.text = releaseDate.game.name
		summarylabel.text = releaseDate.game.summary
	}
}
