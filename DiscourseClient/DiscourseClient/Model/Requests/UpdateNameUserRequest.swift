//
//  UpdateNameUserRequest.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 17/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

struct UpdateNameUserRequest: APIRequest {
    
    typealias Response = UpdateNameUserResponse
    
    let username: String
    let name: String
    
    init(username: String, name: String) {
        self.username = username
        self.name = name
    }
    
    var method: Method {
        return .PUT
    }
    
    var path: String {
        return "/users/\(username).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "name": name
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
