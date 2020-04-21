//
//  LoginCoordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import Foundation
import RxSwift


class MainScreenCoordinator: Coordinator {

    override init(with navigationController: UINavigationController) {
        super.init(with: navigationController)

        let viewController = MainScreenViewController()
        let viewModel = MainScreenViewModel()
        viewController.bind(to: viewModel)

        viewModel.didStart.subscribe(onNext: { [weak self] in
            self?.actOnStart()
        }).disposed(by: disposeBag)

        navigationController.pushViewController(viewController, animated: false)
    }

    private func actOnStart() {
        let homeCoordinator = HomeCoordinator(with: navigationController)
        store(homeCoordinator)
        homeCoordinator.start()
    }
}
