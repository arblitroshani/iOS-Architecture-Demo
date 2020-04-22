//
//  Coordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/22/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit
import RxSwift


public class Coordinator: NSObject, CoordinatorType, UINavigationControllerDelegate {

    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorType]

    var disposeBag: DisposeBag

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.disposeBag = DisposeBag()

        super.init()
    }

    func start() {
        fatalError("start method not implemented")
    }

    func didRemove(_ controller: UIViewController) { }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) { return }

        didRemove(fromViewController)
    }
}
