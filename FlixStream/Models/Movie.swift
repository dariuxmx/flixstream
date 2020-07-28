//
//  Movie.swift
//  FlixStream
//
//  Created by Edwin Dario Gutierrez Pech on 7/27/20.
//  Copyright © 2020 Habanero Studio. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: Date
    let posterPath: String?
    let voteAverage: Double
    var coverURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    // Date format
    static let dateFormatter: DateFormatter = {
        $0.dateFormat = "MMM dd, YYYY"
        return $0
    }(DateFormatter())
    
    var releaseDateText: String {
        return Movie.dateFormatter.string(from: releaseDate)
    }
    
    // Average votes
    var average: String {
        return "\(Int(voteAverage * 10))"
    }
}

