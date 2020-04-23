//
//  MainScreenViewModel.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import RxSwift
import RxCocoa


final class MainScreenViewModel {

    let input: Input
    let output: ViewControllerOutput
    let coordinatorOutput: CoordinatorOutput

    struct Input {
        let startTrigger: PublishRelay<Void>
    }

    struct ViewControllerOutput {

    }

    struct CoordinatorOutput {
        let didStart: Observable<Void>
    }

    init() {
        // MARK: - Input
        let startTrigger = PublishRelay<Void>()

        self.input = Input(startTrigger: startTrigger)

        // MARK: - ViewControllerOutput
        self.output = ViewControllerOutput()

        // MARK: - CoordinatorOutput
        self.coordinatorOutput = CoordinatorOutput(didStart: startTrigger.asObservable())
    }
}
