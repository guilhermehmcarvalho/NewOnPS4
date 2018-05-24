//
//  ReleaseDate.swift
//  PS4WeekReleases
//
//  Created by Guilherme Carvalho on 20/05/2018.
//  Copyright © 2018 gcarvalho. All rights reserved.
//

import Foundation

struct ReleaseDate: Decodable {
    let releaseID: Int
    let game: Game
    let date: Double // Timestamp in miliseconds
    let human: String // Human readable date

    enum CodingKeys: String, CodingKey {
        case releaseID = "id"
        case game, date, human
    }
}
