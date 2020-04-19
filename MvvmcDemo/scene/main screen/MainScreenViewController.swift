//
//  MainScreenViewController.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit


final class MainScreenViewController: UIViewController, BindableType {

    // UI Elements
    fileprivate var mainLabel = MainScreenViewController.mainLabel()
    fileprivate var startButton = MainScreenViewController.startButton()

    // Data Bindings
    private let disposeBag = DisposeBag()
    var viewModel: MainScreenViewModel!

    override func loadView() {
        super.loadView()
        setupViews()
    }

    func bindViewModel() {
        startButton.rx.tap
            .asSignal()
            .emit(to: viewModel.inputs.startTrigger)
            .disposed(by: disposeBag)
    }
}


extension MainScreenViewController {

    fileprivate func setupViews() {
        view.backgroundColor = .white

        // MARK: mainLabel
        view.addSubview(mainLabel)
        mainLabel.anchorCenterSuperview()

        // MARK: startButton
        view.addSubview(startButton)
        startButton.anchorBottomSuperview(constant: 100)
    }

    class func mainLabel() -> UILabel {
        return UILabel(text: "Main Screen",
                       font: .boldSystemFont(ofSize: 30))
    }

    class func startButton() -> UIButton {
        return UIButton(title: "Start",
                        titleColor: .systemBlue,
                        font: .systemFont(ofSize: 22))
    }
}

