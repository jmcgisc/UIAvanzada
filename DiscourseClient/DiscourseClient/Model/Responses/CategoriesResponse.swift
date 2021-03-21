//
//  CategoriesResponse.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 17/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

// DOC Puedes echar un vistazo en https://docs.discourse.org

struct CategoriesResponse: Decodable {
    let categories: Categories
    
    enum CodingKeys: String, CodingKey {
        case categoriesRoot = "category_list"
        case categories
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rootCategories = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .categoriesRoot)
        
        categories = try rootCategories.decode(Categories.self, forKey: .categories)
    }
}


