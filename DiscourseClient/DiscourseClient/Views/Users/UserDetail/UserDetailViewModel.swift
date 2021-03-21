//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 20/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol UserDetailCoordinatorDelegate {
    func userDetailBackButtonTapped(needUpdateUsers: Bool)
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol UserDetailViewDelegate {
    func userDetailFetched()
    func errorFetchingUserDetail()
    func errorModifingUserDetail()
    func successModifingUserDetail()
}

class UserDetailViewModel {
    var labelUserIDText: String?
    var labelUserNameText: String?
    var labelEmailText: String?
    var labelNameText: String?
    var canModifyName = false
    var userModified = false
    
    var viewDelegate: UserDetailViewDelegate?
    var coordinatorDelegate: UserDetailCoordinatorDelegate?
    let userDetailDataManager: UserDetailDataManager
    let username: String
    
    init(username: String, userDetailDataManager: UserDetailDataManager) {
        self.username = username
        self.userDetailDataManager = userDetailDataManager
    }
    
    func viewDidLoad() {
        userDetailDataManager.fetchUser(username: username) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let userResp):
                guard let user = userResp?.user else { return }
                
                self.labelUserIDText = "\(user.id)"
                self.labelUserNameText = user.username
                self.labelEmailText = user.email
                self.labelNameText = user.name
                
                self.canModifyName = user.canEditName ?? false
                
                self.viewDelegate?.userDetailFetched()
                
            case .failure(_):
                self.viewDelegate?.errorFetchingUserDetail()
            }
        }
    }
    
    func modifyUser(newName: String) {
        userDetailDataManager.updateName(username: username, name: newName) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success:
                self.userModified = true
                self.viewDelegate?.successModifingUserDetail() 
                self.viewDelegate?.errorModifingUserDetail()
                case .failure(_):
                    fatalError();
            }
        }
    }
    
    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped(needUpdateUsers: userModified)
    }
}
