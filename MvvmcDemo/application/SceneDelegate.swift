//
//  SceneDelegate.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private lazy var mainWindow = UIWindow()
    var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        mainWindow = UIWindow(windowScene: windowScene)
        appCoordinator = AppCoordinator(window: mainWindow)
        appCoordinator.start()
    }
}

