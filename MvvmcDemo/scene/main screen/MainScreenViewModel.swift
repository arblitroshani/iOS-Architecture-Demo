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
    let output: Output

    struct Input {
        let startTrigger: PublishRelay<Void>
    }

    struct Output {
        let didStart: Observable<Void>
    }

    init() {
        // MARK: - Input
        let startTrigger = PublishRelay<Void>()

        self.input = Input(startTrigger: startTrigger)

        // MARK: - Output
        self.output = Output(didStart: startTrigger.asObservable())
    }
}
