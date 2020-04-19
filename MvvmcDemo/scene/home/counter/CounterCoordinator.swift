//
//  CounterCoordinator.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit
import RxSwift


class CounterCoordinator: Coordinator {

    override init(parentCoordinator: CoordinatorType?) {
        super.init(parentCoordinator: parentCoordinator)

        let counterViewModel = CounterViewModel()
        didDismiss = counterViewModel.didDismiss
        
        let counterViewController = CounterViewController()
        counterViewController.bind(to: counterViewModel)

        rootViewController = counterViewController
    }
}
