//
//  CounterViewController.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit


final class CounterViewController: UIViewController, BindableType {

    // UI Elements
    fileprivate var titleLabel = CounterViewController.titleLabel()
    fileprivate var dismissButton = CounterViewController.dismissButton()

    // Data Bindings
    private let disposeBag = DisposeBag()
    var viewModel: CounterViewModel!

    override func loadView() {
        super.loadView()
        setupViews()
    }

    func bindViewModel() {
        dismissButton.rx.tap
            .asSignal()
            .emit(to: viewModel.input.tapTrigger)
            .disposed(by: disposeBag)

        viewModel.output.didSetTitle
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension CounterViewController {

    fileprivate func setupViews() {
        view.backgroundColor = .secondary

        // MARK: titleLabel
        view.addSubview(titleLabel)
        titleLabel.anchorCenterSuperview()

        // MARK: dismissButton
        view.addSubview(dismissButton)
        dismissButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor, bottomConstant: 50,
            centerX: view.safeAreaLayoutGuide.centerXAnchor)
    }

    class func titleLabel() -> UILabel {
        return UILabel(text: "",
                       font: .boldSystemFont(ofSize: 30),
                       textColor: .white,
                       textAlignment: .center)
    }

    class func dismissButton() -> UIButton {
        let button = UIButton(title: "Tap",
                              titleColor: .white,
                              font: .boldSystemFont(ofSize: 22),
                              backgroundColor: .primary)
        button.layer.cornerRadius = 20
        return button.withSize(.init(width: 220, height: 60))
    }
}
