//
//  CoordinatorType.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit
import RxSwift


protocol CoordinatorType: class {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorType] { get set }
    var disposeBag: DisposeBag { get set }

    func start()
}


extension CoordinatorType {

    func store(_ child: CoordinatorType) {
        childCoordinators.append(child)
    }

    func free(_ child: CoordinatorType) {
        childCoordinators = childCoordinators.filter { $0 !== child }
    }
}
