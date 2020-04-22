//
//  HomeTabBarController.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/19/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit


class HomeTabBarController: UITabBarController {

    weak var coordinator: HomeCoordinator?

    init(with viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
        self.tabBar.tintColor = .primary

        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HomeTabBarController: UITabBarControllerDelegate {

    func tabBarController(
        _ tabBarController: UITabBarController,
        shouldSelect viewController: UIViewController) -> Bool
    {
        guard let selectedController = tabBarController.selectedViewController,
            let fromView = selectedController.view,
            let toView = viewController.view,
            fromView != toView
        else { return false }

        UIView.transition(
            from: fromView,
            to: toView,
            duration: 0.1,
            options: .transitionCrossDissolve,
            completion: nil)

        return true
    }
}
