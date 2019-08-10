//
//  UserDetailsModel.swift
//  Movie App Task
//
//  Created by hosam on 8/10/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

struct UserDetailsModel:Codable {
    
    let avatar: Avatar
    let id: Int
    let iso639_1, iso3166_1, name: String
    
    let includeAdult: Bool
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

struct Avatar: Codable {
    let gravatar: Gravatar
}

struct Gravatar: Codable {
    let hash: String
}
