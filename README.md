# iOS Architecture Demo
![build](https://github.com/arblitroshani/iOS-Architecture-Demo/workflows/build/badge.svg?branch=master)

Basic app showcasing MVVM-C architecture with RxSwift FRP.

## Overview

- MVVM base architecture
- Coordinator patern for handling navigation
- RxSwift and RxCocoa frameworks for bindings
- RxTest and RxBlocking frameworks for unit tests
- Layouts created programmatically

## Coordinator  
###### location: `/util/base/`
  - Base class that conforms to `CoordinatorType` protocol
  - `childCoordinators` used to keep strong references to newly created coordinators
  - `parentCoordinator` used to keep a weak reference to the parent coordinator, which is injected in `init()`
  - `didDismiss: Single<Void>` example of intra-coordinator communication
  - `WindowCoordinator` is a subclass of `Coordinator` that also conforms to `WindowInitializable`.
  - On initial load, `SceneDelegate` creates `AppCoordinator` and injects the newly created `UIWindow` instance.
  
### App Coordinator
###### location: `/application/`
- subclasses `WindowCoordinator`
- created and strongly referenced by `SceneDelagate` on initial load
- creates, stores, starts the first coordinator.
- sets the `window.rootViewController` and calls `window.makeKeyAndVisible()`
- other initialization code that might not be appropriate for `AppDelegate` or `SceneDelegate`.
- 
## ViewModel
###### location: `/scene/*/...ViewModel.swift`
- must not import `UIKit`
- has protocols defined for `Input` and `Output` to achieve type safety and have more control
- any `button.rx.tap` Observable sequence comes from the `ViewController` as `Signal<Void>` which emits to a `PublishRelay<Void>` in the `ViewModel`
- other non-void Observable sequences from the `ViewController` come as `Driver<T>` which drive a `BehaviorRelay<T>` in the `ViewModel`.
- all output from the `ViewModel` that is aimed to the `ViewController` is a `Driver<T>`
- other output aimed at it's Coordinator' can be an `Observable` or other `Traits`
- all output should be direct mapping of input
- should not keep state implicitly, but rather utilize operators such as [scan()](http://reactivex.io/documentation/operators/scan.html)

## ViewController
###### location: `/scene/*/...ViewController.swift`
- conforms to `BindableType` which enforces having a `viewModel` attribute and `bindViewModel()` method
- extension to `BindableType` adds `bind(to:loadIfNeeded:)` which is called from the coordinator. Used to inject the `ViewModel` to the `ViewController`.

## Unit Tests
- `testViewModelEmitsInitialValue()` demonstrates the usage of `RxBlocking` to get an array of a certain length from `viewModel.didSetTitle`
- other tests use `RxTest` which binds an `Observable<T>` object to a `TestableObservable<T>` and lets you easily check expected values and times
- [build workflow](https://github.com/arblitroshani/iOS-Architecture-Demo/actions?query=workflow%3Abuild) builds and runs all tests automatically on each push to `master`

----

### Inspiration from:
- [bhlvoong/LBTATools](https://github.com/bhlvoong/LBTATools)
- [kickstarter/ios-oss](https://github.com/kickstarter/ios-oss)
- [quickbirdstudios/XCoordinator](https://github.com/quickbirdstudios/XCoordinator)

### Work in progress.
