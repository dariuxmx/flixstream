//
//  MovieResponse.swift
//  FlixStream
//
//  Created by Edwin Dario Gutierrez Pech on 7/27/20.
//  Copyright © 2020 Habanero Studio. All rights reserved.
//

import Foundation

public struct MovieResponse: Codable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
    let totalResults: Int
}
