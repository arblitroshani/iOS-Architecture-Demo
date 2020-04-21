//
//  Coordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/22/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit
import RxSwift


public class Coordinator: CoordinatorType {

    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorType]

    var disposeBag: DisposeBag

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
        self.disposeBag = DisposeBag()
    }

    func start() {
        fatalError("start not implemented")
    }
}
