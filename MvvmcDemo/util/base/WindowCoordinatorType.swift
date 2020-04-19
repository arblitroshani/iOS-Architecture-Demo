//
//  AppCoordinatorType.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/18/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit


protocol WindowCoordinatorType: CoordinatorType {
    var window: UIWindow { get set }
}


public class WindowCoordinator: Coordinator, WindowCoordinatorType {

    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init(parentCoordinator: nil)
    }
}

