//
//  Game.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 20/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation

struct Game: Decodable {
    let gameID: Int
    let name: String
    let summary: String?
	let cover: Cover?

    enum CodingKeys: String, CodingKey {
        case gameID = "id"
        case name, summary, cover
    }

}
