//
//  AppCoordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit


class AppCoordinator: WindowCoordinator {

    override func start() {
        let mainScreenCoordinator = MainScreenCoordinator(parentCoordinator: self)
        store(mainScreenCoordinator)

        window.rootViewController = mainScreenCoordinator.rootViewController
        window.makeKeyAndVisible()
    }
}
