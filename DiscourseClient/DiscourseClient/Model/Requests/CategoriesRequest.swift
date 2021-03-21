//
//  CategoriesRequest.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 17/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

/// Implementación de la request que obtiene las categorias
struct CategoriesRequest: APIRequest {
    
    typealias Response = CategoriesResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/categories.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
