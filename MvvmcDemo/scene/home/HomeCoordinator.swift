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

    private let disposeBag = DisposeBag()

    override init(parentCoordinator: CoordinatorType?) {
        super.init(parentCoordinator: parentCoordinator)

        let counterCoordinator = CounterCoordinator(parentCoordinator: self)
        let secondCoordinator = SecondCoordinator(parentCoordinator: self)

        store(counterCoordinator)
        store(secondCoordinator)

        guard let counterVc = counterCoordinator.rootViewController,
            let userListVc = secondCoordinator.rootViewController
        else {
            print("RootViewControllers not initialized")
            return
        }

        counterVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        userListVc.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let tabBarController = HomeTabBarController(with: [counterVc, userListVc])
        rootViewController = tabBarController

        counterCoordinator.didDismiss.subscribe(onSuccess: { [weak self] in
            self?.actOnDismiss()
        }).disposed(by: disposeBag)
    }

    override func start() {
        guard let parentController = parentCoordinator?.rootViewController,
            let rootViewController = rootViewController
        else { return }

        rootViewController.modalPresentationStyle = .fullScreen
        parentController.present(rootViewController, animated: true)
    }

    private func actOnDismiss() {
        rootViewController?.dismiss(animated: true)
        parentCoordinator?.rootViewController?.setNeedsStatusBarAppearanceUpdate()

        childCoordinators.removeAll()
    }
}
