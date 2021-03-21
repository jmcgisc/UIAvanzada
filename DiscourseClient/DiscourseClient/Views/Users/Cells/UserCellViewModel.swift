//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 17/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

protocol UserCellViewModelDelegate{
    func userImageFetched()
}

class UserCellViewModel {
    
    // MARK: Constants
    static let imageSize = 100
    let user: User
    
    // MARK: Variables
    var delegate: UserCellViewModelDelegate?
    var textLabelText: String?
    var avatarImage: UIImage? {
        didSet {
            delegate?.userImageFetched()
        }
    }
    
    init(user: User) {
        self.user = user
        self.textLabelText = user.name ?? user.username
        
        let avatarUrl: String = user.avatarTemplate.replacingOccurrences(of: "{size}", with: "\(UserCellViewModel.imageSize)")
        if let imageUrl = URL(string: "\(apiURL)\(avatarUrl)") {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let data = try? Data(contentsOf: imageUrl),
                    let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self?.avatarImage = image
                }
            }
        }
    }
}
