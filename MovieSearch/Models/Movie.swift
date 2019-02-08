//
//  Movie.swift
//  MovieSearch
//
//  Created by XMS_JZhan on 2/8/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import Foundation

struct TopLevelJSON: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let rating: Double
    let overview: String
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case rating = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}
