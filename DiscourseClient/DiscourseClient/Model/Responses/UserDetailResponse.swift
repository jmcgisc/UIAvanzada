//
//  UserDetailResponse.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 17/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

// Puedes echar un vistazo en https://docs.discourse.org

struct UserDetailResponse: Decodable {
    let user: User
    
    init(from decoder: Decoder) throws {
        let rootObject = try decoder.singleValueContainer()
        user = try rootObject.decode(User.self)
    }
}
