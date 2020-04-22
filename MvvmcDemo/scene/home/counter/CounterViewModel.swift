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


protocol CounterViewModelInputsType {
    var tapTrigger: PublishRelay<Void> { get }
}

protocol CounterViewModelOutputsType {
    var didSetTitle: Driver<String> { get }
    var didRequestDismiss: Single<Void> { get }
}

protocol CounterViewModelType: class {
    var inputs: CounterViewModelInputsType { get }
    var outputs: CounterViewModelOutputsType { get }
}


final class CounterViewModel: CounterViewModelType {

    var inputs: CounterViewModelInputsType { return self }
    var outputs: CounterViewModelOutputsType { return self }

    // Setup
    let disposeBag: DisposeBag

    // Inputs
    var tapTrigger: PublishRelay<Void>

    // Outputs
    var didSetTitle: Driver<String>
    var didRequestDismiss: Single<Void>

    // ViewModel Life Cycle

    init() {
        // Setup
        self.disposeBag = DisposeBag()

        // Inputs
        tapTrigger = PublishRelay()

        // Outputs
        let backwardsCounterObservable = tapTrigger.asObservable()
            .startWith(())
            .scan(10 + 1) { prev, _ in prev - 1 }

        didSetTitle = backwardsCounterObservable
            .map { "\($0) more tap\($0 > 1 ? "s" : "") to dismiss" }
            .asDriver(onErrorJustReturn: "Error")

        let didReachZero = backwardsCounterObservable
            .filter { $0 == 0 }
            .map { _ in () }

        didRequestDismiss = didReachZero.take(1).asSingle()

        // View Model Lifcycle

    }
}


extension CounterViewModel: CounterViewModelInputsType, CounterViewModelOutputsType { }
