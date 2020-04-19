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

    private let disposeBag: DisposeBag

    override init(parentCoordinator: CoordinatorType?) {
        disposeBag = DisposeBag()

        super.init(parentCoordinator: parentCoordinator)

        let viewController = MainScreenViewController()
        let viewModel = MainScreenViewModel()
        viewController.bind(to: viewModel)

        viewModel.didStart.subscribe(onNext: { [weak self] in
            self?.actOnStart()
        }).disposed(by: disposeBag)

        rootViewController = viewController
    }

    private func actOnStart() {
        let homeCoordinator = HomeCoordinator(parentCoordinator: self)
        store(homeCoordinator)
        homeCoordinator.start()
    }
}
