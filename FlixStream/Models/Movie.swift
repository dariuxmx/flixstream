//
//  Movie.swift
//  FlixStream
//
//  Created by Edwin Dario Gutierrez Pech on 7/27/20.
//  Copyright © 2020 Habanero Studio. All rights reserved.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
    let totalResults: Int
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: Date
}

