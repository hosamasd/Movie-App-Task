//
//  TopRatedModel.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

struct MovieModel: Codable {
    
    let results: [Results]
    let page, totalResults, totalPages: Int
  
    
    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct Results: Codable,Equatable {
//    let voteCount, id: Int
//    let video: Bool
//    let voteAverage: Double
//    let title: String
//    let popularity: Double
//    let posterPath: String
//    let originalTitle: String
//    let genreIDS: [Int]
//    let backdropPath: String
//    let adult: Bool
//    let overview, releaseDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case voteCount = "vote_count"
//        case id, video
//        case voteAverage = "vote_average"
//        case title, popularity
//        case posterPath = "poster_path"
//        case originalTitle = "original_title"
//        case genreIDS = "genre_ids"
//        case backdropPath = "backdrop_path"
//        case adult, overview
//        case releaseDate = "release_date"
//    }
    
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage, originalTitle: String
    
    let genreIDS: [Int]
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case video
        case posterPath = "poster_path"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
