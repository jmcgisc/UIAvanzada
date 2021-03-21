//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 20/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

/// DataManager con las operaciones necesarias de este módulo
protocol UserDetailDataManager {
    func fetchUser(username: String, completion: @escaping (Result<UserDetailResponse?, Error>) -> ())
    func updateName(username: String, name: String, completion: @escaping (Result<UpdateNameUserResponse?, Error>) -> ())
}
