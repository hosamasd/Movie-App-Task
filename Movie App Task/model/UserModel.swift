//
//  UserModel.swift
//  Movie App Task
//
//  Created by hosam on 8/9/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import Foundation

struct UserModel:Codable {

    let success: Bool
    let expiresAt, requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
