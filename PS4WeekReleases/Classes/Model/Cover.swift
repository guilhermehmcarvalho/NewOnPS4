//
//  Cover.swift
//  PS4WeekReleases
//
//  Created by Guilherme on 22/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation

struct Cover: Decodable {
	let url: String
	let hash: String
	let width: Int
	let height: Int
	
	enum CodingKeys: String, CodingKey {
		case hash = "cloudinary_id"
		case url, width, height
	}
}
