//
//  MVVMC_FRP_DemoTests.swift
//  MvvmcDemoTests
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
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
        let expectedTitle = "10 more taps to dismiss"
        let emittedTitle = try! viewModel.didSetTitle.toBlocking().first()!

        XCTAssertEqual(emittedTitle, expectedTitle)
    }

    func testCounterTitle() {
        tapOnButton(times: 2, spacing: 100)

        let results = scheduler.createObserver(String.self)
        let expected: [Recorded<Event<String>>] = [
            .next(0, "10 more taps to dismiss"),
            .next(100, "9 more taps to dismiss"),
            .next(200, "8 more taps to dismiss")
        ]

        startObserving(viewModel.didSetTitle.asObservable(), at: results)

        XCTAssertEqual(results.events, expected)
    }

    func testViewModelIssuesDismissWhenCounterReachesZero() {
        tapOnButton(times: 10, spacing: 100)

        let results = scheduler.createObserver(Void.self)
        let expectedTime = 1000

        startObserving(viewModel.didDismiss.asObservable(), at: results)

        XCTAssertFalse(results.events.first!.value.isCompleted)
        XCTAssertEqual(results.events.first!.time, expectedTime)
    }

    func testCounterUsesSingularNameCorrectly() {
        tapOnButton(times: 9, spacing: 100)

        let results = scheduler.createObserver(String.self)
        let expected = Recorded.next(900, "1 more tap to dismiss")

        startObserving(viewModel.didSetTitle.asObservable(), at: results)

        XCTAssertEqual(results.events.last, expected)
    }

    private func tapOnButton(times: Int, spacing: Int) {
        let buttonTaps = (1 ... times).map { Recorded.next(spacing * $0, ()) }

        scheduler
            .createHotObservable(buttonTaps)
            .asObservable()
            .bind(to: viewModel.inputs.tapTrigger)
            .disposed(by: self.disposeBag)
    }

    private func startObserving<T>(_ observable: Observable<T>, at results: TestableObserver<T>) {
        scheduler.scheduleAt(0) {
            observable
                .subscribe(results)
                .disposed(by: self.disposeBag)
        }
        scheduler.start()
    }
}
