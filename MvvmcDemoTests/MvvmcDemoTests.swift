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

    override func setUp() {
        super.setUp()

        self.disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }

    // MARK: - Tests

    func testViewModelEmitsInitialValue() {
        let emittedTitle = getFirstEmittedTitle(startWith: 10)
        XCTAssertEqual(emittedTitle, "10 more taps to dismiss")
    }

    func testCustomValueViewModelInitialValue() {
        let emittedTitle = getFirstEmittedTitle(startWith: 3)
        XCTAssertEqual(emittedTitle, "3 more taps to dismiss")
    }

    func testIncorrectValueViewModelInitialValue() {
        let emittedTitle = getFirstEmittedTitle(startWith: -1)
        XCTAssertEqual(emittedTitle, "1 more tap to dismiss")
    }

    func testCounterTitleStartingWithDefaultValue() {
        let (events, taps) = getTitleResultEvents(startWith: 10, forTapCount: 2)

        let expected: [Recorded<Event<String>>] = [
            .next(0, "10 more taps to dismiss"),
            .next(taps[0], "9 more taps to dismiss"),
            .next(taps[1], "8 more taps to dismiss")
        ]

        XCTAssertEqual(events.count, 3)
        XCTAssertEqual(events, expected)
    }

    func testCounterTitleStartingWithCustomValue() {
        let (events, taps) = getTitleResultEvents(startWith: 5, forTapCount: 2)

        let expected: [Recorded<Event<String>>] = [
            .next(0, "5 more taps to dismiss"),
            .next(taps[0], "4 more taps to dismiss"),
            .next(taps[1], "3 more taps to dismiss")
        ]

        XCTAssertEqual(events.count, 3)
        XCTAssertEqual(events, expected)
    }

    func testViewModelIssuesDismissWhenCounterReachesZero() {
        let viewModel = CounterViewModel(startWith: 10)
        let (events, taps) = getResultEvents(from: viewModel.output.didRequestDismiss.asObservable(),
                                             forTapCount: 10,
                                             to: viewModel.input.tapTrigger)

        XCTAssertNotNil(events.first)
        XCTAssertFalse(events.first!.value.isCompleted)
        XCTAssertEqual(events.first!.time, taps.last!)
    }

    func testCounterUsesSingularNameCorrectly() {
        let (events, _) = getTitleResultEvents(startWith: 10, forTapCount: 9)

        XCTAssertNotNil(events.last)
        XCTAssertNotNil(events.last!.value.element)
        XCTAssertEqual(events.last!.value.element!, "1 more tap to dismiss")
    }

    // MARK: - Helper methods

    private func getFirstEmittedTitle(startWith startValue: Int) -> String {
        return try! CounterViewModel(startWith: startValue)
            .output.didSetTitle
            .toBlocking()
            .first()!
    }

    @discardableResult
    private func sendTapEvents(
        to observer: PublishRelay<Void>,
        times: Int, spacing: Int = 10) -> [Int]
    {
        let buttonTaps = (1 ... times).map { spacing * $0 }
        let buttonTapEvents = buttonTaps.map { Recorded.next($0, ()) }

        scheduler
            .createHotObservable(buttonTapEvents)
            .asObservable()
            .bind(to: observer)
            .disposed(by: disposeBag)

        return buttonTaps
    }

    private func getResultEvents<T>(
        from observable: Observable<T>,
        forTapCount tapCount: Int,
        to tapObserver: PublishRelay<Void>) -> ([Recorded<Event<T>>], [Int])
    {
        let taps = sendTapEvents(to: tapObserver, times: tapCount)

        let results = scheduler.createObserver(T.self)
        observable
            .subscribe(results)
            .disposed(by: disposeBag)
        scheduler.start()

        return (results.events, taps)
    }

    private func getTitleResultEvents(
        startWith startValue: Int,
        forTapCount tapCount: Int) -> ([Recorded<Event<String>>], [Int])
    {
        let viewModel = CounterViewModel(startWith: startValue)
        return getResultEvents(from: viewModel.output.didSetTitle.asObservable(),
                               forTapCount: tapCount,
                               to: viewModel.input.tapTrigger)
    }
}
