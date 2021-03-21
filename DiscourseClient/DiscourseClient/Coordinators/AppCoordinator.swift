//
//  AppCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//


import UIKit

/// Coordinator principal de la app. Encapsula todas las interacciones con la Window.
/// Tiene dos hijos, el topic list, y el categories list (uno por cada tab)
class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()
    
    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()
    
    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()
    
    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let splashVc = SplashViewController()
        splashVc.splashDidFinish = startApp

        window.rootViewController = splashVc
        window.makeKeyAndVisible()
    }
    
    private func startApp() {
        let tabBarController = UITabBarController()
        
        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()
        
        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController,
                                                usersDataManager: dataManager,
                                                userDetailDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()
        
        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage(named: "inicio")?.withRenderingMode(.alwaysTemplate)
        tabBarController.tabBar.items?[1].image = UIImage(named: "usuarios")?.withRenderingMode(.alwaysTemplate)

        window.rootViewController = tabBarController
    }
    
    override func finish() {}
}
