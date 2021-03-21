//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by jose manuel carreiro galicia on 17/3/21.
//  Copyright © 2021 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDetailDataManager: UserDetailDataManager
    var usersViewModel: UsersViewModel?
    
    init(presenter: UINavigationController, usersDataManager: UsersDataManager,
         userDetailDataManager: UserDetailDataManager) {
        
        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        self.usersViewModel = usersViewModel
        presenter.pushViewController(usersViewController, animated: false)
    }
    
    override func finish() {}
}

extension UsersCoordinator: UsersCoordinatorDelegate {
    func didSelect(user: User) {
        let userDetailViewModel = UserDetailViewModel(username: user.username, userDetailDataManager: userDetailDataManager)
        let userDetailViewController = UserDetailViewController(viewModel: userDetailViewModel)
        userDetailViewModel.coordinatorDelegate = self
        userDetailViewModel.viewDelegate = userDetailViewController
        presenter.pushViewController(userDetailViewController, animated: true)
    }
}

extension UsersCoordinator: UserDetailCoordinatorDelegate {
    func userDetailBackButtonTapped(needUpdateUsers: Bool = false) {
        presenter.popViewController(animated: true)
        
        if needUpdateUsers {
            usersViewModel?.refreshUsers()
        }
    }
}
