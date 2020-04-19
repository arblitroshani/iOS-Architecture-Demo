//
//  SecondViewController.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/17/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit


class SecondViewController: UIViewController {

    // UI Elements
    fileprivate var titleLabel = SecondViewController.titleLabel()

    override func loadView() {
        super.loadView()
        setupViews()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension SecondViewController {

    fileprivate func setupViews() {
        view.backgroundColor = .primaryLight

        // MARK: titleLabel
        view.addSubview(titleLabel)
        titleLabel.anchorCenterSuperview()
    }

    class func titleLabel() -> UILabel {
        return UILabel(text: "Second screen",
                       font: .boldSystemFont(ofSize: 30),
                       textColor: .white,
                       textAlignment: .center)
    }
}

