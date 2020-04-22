//
//  MVVMC_FRP_DemoTests.swift
//  MvvmcDemoTests
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxCocoa
import RxBlocking
@testable import MvvmcDemo


class MvvmcDemoTests: XCTestCase {

    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    var viewModel: CounterViewModel!

    override func setUp() {
        super.setUp()

        self.disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)

        self.viewModel = CounterViewModel()
    }

    func testViewModelEmitsInitialValue() {
        let emittedTitle = try! viewModel.outputs.didSetTitle.toBlocking().first()!
        XCTAssertEqual(emittedTitle, "10 more taps to dismiss")
    }

    func testCounterTitle() {
        let taps = tapOnButton(times: 2)

        let results = scheduler.createObserver(String.self)
        viewModel.outputs.didSetTitle
            .drive(results)
            .disposed(by: disposeBag)
        scheduler.start()

        let expected: [Recorded<Event<String>>] = [
            .next(0, "10 more taps to dismiss"),
            .next(taps[0], "9 more taps to dismiss"),
            .next(taps[1], "8 more taps to dismiss")
        ]

        XCTAssertEqual(results.events.count, 3)
        XCTAssertEqual(results.events, expected)
    }

    func testViewModelIssuesDismissWhenCounterReachesZero() {
        let taps = tapOnButton(times: 10)

        let results = scheduler.createObserver(Void.self)
        viewModel.outputs.didRequestDismiss
            .asObservable()
            .subscribe(results)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertNotNil(results.events.first)
        XCTAssertFalse(results.events.first!.value.isCompleted)
        XCTAssertEqual(results.events.first!.time, taps.last!)
    }

    func testCounterUsesSingularNameCorrectly() {
        tapOnButton(times: 9, spacing: 100)

        let results = scheduler.createObserver(String.self)
        viewModel.outputs.didSetTitle
            .drive(results)
            .disposed(by: disposeBag)
        scheduler.start()

        XCTAssertNotNil(results.events.last)
        XCTAssertNotNil(results.events.last!.value.element)
        XCTAssertEqual(results.events.last?.value.element!, "1 more tap to dismiss")
    }

    @discardableResult
    private func tapOnButton(times: Int, spacing: Int = 10) -> [Int] {
        let buttonTaps = (1 ... times).map { spacing * $0 }
        let buttonTapEvents = buttonTaps.map { Recorded.next($0, ()) }

        scheduler
            .createHotObservable(buttonTapEvents)
            .asObservable()
            .bind(to: viewModel.inputs.tapTrigger)
            .disposed(by: disposeBag)

        return buttonTaps
    }
}
