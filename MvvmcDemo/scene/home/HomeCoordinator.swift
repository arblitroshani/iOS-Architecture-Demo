//
//  HomeCoordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import Foundation
import RxSwift


class HomeCoordinator: Coordinator {

    private let tabBarController: UIViewController

    override init(with navigationController: UINavigationController) {
        // MARK: CounterViewController
        let counterViewModel = CounterViewModel()
        let counterViewController = CounterViewController()
        counterViewController.bind(to: counterViewModel)
        counterViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        // MARK: SecondViewController
        let secondViewController = SecondViewController()
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        // MARK: HomeTabBarController
        tabBarController = HomeTabBarController(with: [counterViewController, secondViewController])

        super.init(with: navigationController)

        counterViewModel.didDismiss.subscribe(onSuccess: { [weak self] in
            self?.actOnDismiss()
        }).disposed(by: disposeBag)
    }

    override func start() {
        navigationController.pushViewController(tabBarController, animated: true)
    }

    private func actOnDismiss() {
        navigationController.popViewController(animated: true)
        navigationController.viewControllers.last?.setNeedsStatusBarAppearanceUpdate()
    }
}
