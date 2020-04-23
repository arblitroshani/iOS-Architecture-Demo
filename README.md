# iOS Architecture Demo
![swift](https://img.shields.io/badge/swift-5.0-brightgreen)&nbsp; ![build](https://github.com/arblitroshani/iOS-Architecture-Demo/workflows/build/badge.svg?branch=master)    

Basic app showcasing MVVM-C architecture with RxSwift FRP.

## Overview

- MVVM base architecture
- Coordinator patern for handling navigation
- RxSwift and RxCocoa frameworks for bindings
- RxTest and RxBlocking frameworks for testing
- Layouts created programmatically

## Coordinator  
###### location: `/util/base/`
  - Base class that conforms to `CoordinatorType` protocol
  - `childCoordinators` used to keep strong references to created coordinators
  - `AppCoordinator` is a subclass of `Coordinator` that uses a `UIWindow` instance injected from  `SceneDelegate` on initial load
  - Subclasses of `Coordinator` can set themselves as a delegate of `UINavigationControllerDelegate` and can get notified when a `ViewController` is popped from `navigationController` by overriding `didRemove(_:)`
  
## ViewModel
###### location: `/scene/*/...ViewModel.swift`
- must not import `UIKit`
- any `button.rx.tap` Observable sequence comes from the `ViewController` as `Signal<Void>` which emits to a `PublishRelay<Void>` in the `ViewModel`
- other non-void Observable sequences from the `ViewController` come as `Driver<T>` which drive a `BehaviorRelay<T>` in the `ViewModel`.
- all output from the `ViewModel` that is aimed to the `ViewController` is a `Driver<T>`
- other output aimed at it's Coordinator' can be an `Observable` or other `Traits`
- all output should be direct mapping of input
- should not keep state explicitly, but rather utilize operators such as [`scan()`](http://reactivex.io/documentation/operators/scan.html)

## ViewController
###### location: `/scene/*/...ViewController.swift`
- conforms to `BindableType` which enforces having a `viewModel` attribute and `bindViewModel()` method
- extension to `BindableType` adds `bind(to:loadIfNeeded:)` which is called from the `Coordinator`. Used to inject the `ViewModel` to the `ViewController`.

## Unit Tests
- `testViewModelEmitsInitialValue()` demonstrates the usage of `RxBlocking` to get an array of a certain length from `viewModel.didSetTitle`
- other tests use `RxTest` which binds an `Observable<T>` object to a `TestableObservable<T>` and lets you easily check expected values and times
- [build workflow CI](https://github.com/arblitroshani/iOS-Architecture-Demo/actions?query=workflow%3Abuild) builds and runs all tests on each push to `master`

----

### Inspiration from:
- [Coordinator pattern by Soroush Khanlou](https://khanlou.com/2015/01/the-coordinator/)
- [Advanced Coordinators in iOS by Paul Hudson](https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios)
- [popei69/TemplateProject](https://github.com/popei69/TemplateProject)
- [kickstarter/ios-oss](https://github.com/kickstarter/ios-oss)
- [quickbirdstudios/XCoordinator](https://github.com/quickbirdstudios/XCoordinator)
- [bhlvoong/LBTATools](https://github.com/bhlvoong/LBTATools)

### Work in progress.

