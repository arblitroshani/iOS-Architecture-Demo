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

    private let tabBarController: HomeTabBarController

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
        tabBarController = .init(with: [counterViewController, secondViewController])

        super.init(with: navigationController)

        counterViewModel.coordinatorOutput.didRequestDismiss.subscribe(onSuccess: { [weak self] in
            self?.actOnDismissRequest()
        }).disposed(by: disposeBag)
    }

    override func start() {
        tabBarController.coordinator = self
        navigationController.pushViewController(tabBarController, animated: true)
    }

    private func actOnDismissRequest() {
        navigationController.popViewController(animated: true)
        navigationController.viewControllers.last?.setNeedsStatusBarAppearanceUpdate()
    }
}
