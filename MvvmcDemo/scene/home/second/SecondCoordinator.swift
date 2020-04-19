//
//  SecondCoordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit


class SecondCoordinator: Coordinator {

    override init(parentCoordinator: CoordinatorType?) {
        super.init(parentCoordinator: parentCoordinator)

        let secondViewController = SecondViewController()
        rootViewController = secondViewController
    }
}
