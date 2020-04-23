//
//  CounterViewModel.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


final class CounterViewModel {

    let input: Input
    let output: Output

    struct Input {
        let tapTrigger: PublishRelay<Void>
    }

    struct Output {
        let didSetTitle: Driver<String>
        let didRequestDismiss: Single<Void>
    }

    // Setup
    private let disposeBag: DisposeBag

    init(startWith startValue: Int = 10) {
        // MARK: - Setup
        self.disposeBag = DisposeBag()

        // MARK: - Input
        let tapTrigger = PublishRelay<Void>()

        self.input = Input(tapTrigger: tapTrigger)

        // MARK: - Output
        let backwardsCounterObservable = tapTrigger.asObservable()
            .startWith(())
            .scan(max(1, startValue) + 1) { prev, _ in prev - 1 }

        let didSetTitle = backwardsCounterObservable
            .map { "\($0) more tap\($0 > 1 ? "s" : "") to dismiss" }
            .asDriver(onErrorJustReturn: "Error")

        let didReachZero = backwardsCounterObservable
            .filter { $0 == 0 }
            .map { _ in () }

        self.output = Output(didSetTitle: didSetTitle,
                             didRequestDismiss: didReachZero.take(1).asSingle())
    }
}
