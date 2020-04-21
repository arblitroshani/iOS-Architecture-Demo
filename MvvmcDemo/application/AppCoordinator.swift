//
//  AppCoordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit


class AppCoordinator: Coordinator {

    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        let appNavigationController = UINavigationController()
        appNavigationController.isNavigationBarHidden = true
        super.init(with: appNavigationController)
    }

    override func start() {
        let mainScreenCoordinator = MainScreenCoordinator(with: navigationController)
        store(mainScreenCoordinator)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
