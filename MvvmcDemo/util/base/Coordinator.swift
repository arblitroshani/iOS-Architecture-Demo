//
//  Coordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit
import RxSwift


protocol CoordinatorType: class {
    var rootViewController: UIViewController? { get set }
    var navigationController: UINavigationController? { get set }
    var childCoordinators: [CoordinatorType] { get set }
    var parentCoordinator: CoordinatorType? { get set }
    var didDismiss: Single<Void> { get set }

    func start()
}


extension CoordinatorType {

    func store(_ child: CoordinatorType) {
        child.navigationController = navigationController
        childCoordinators.append(child)
    }

    func free(_ child: CoordinatorType) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}


public class Coordinator: CoordinatorType {

    var rootViewController: UIViewController?
    var navigationController: UINavigationController?
    weak var parentCoordinator: CoordinatorType?

    var childCoordinators: [CoordinatorType]

    var didDismiss: Single<Void>

    init(parentCoordinator: CoordinatorType?) {
        self.parentCoordinator = parentCoordinator
        self.childCoordinators = []
        didDismiss = Observable.empty().asSingle()
    }

    func start() {
        fatalError("start not implemented")
    }
}
