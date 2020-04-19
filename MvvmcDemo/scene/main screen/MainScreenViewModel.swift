//
//  MainScreenViewModel.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import RxSwift
import RxCocoa


protocol MainScreenViewModelInputsType {
    var startTrigger: PublishRelay<Void> { get }
}

protocol MainScreenViewModelOutputsType {
    var didStart: Observable<Void> { get }
}

protocol MainScreenViewModelType: class {
    var inputs: MainScreenViewModelInputsType { get }
    var outputs: MainScreenViewModelOutputsType { get }
}


final class MainScreenViewModel: MainScreenViewModelType {

    var inputs: MainScreenViewModelInputsType { return self }
    var outputs: MainScreenViewModelOutputsType { return self }

    // Setup

    // Inputs
    let startTrigger: PublishRelay<Void>

    // Outputs
    var didStart: Observable<Void>

    // ViewModel Life Cycle

    init() {
        // Setup

        // Inputs
        startTrigger = PublishRelay()

        // Outputs
        didStart = startTrigger.asObservable()
    }
}


extension MainScreenViewModel: MainScreenViewModelInputsType, MainScreenViewModelOutputsType { }

