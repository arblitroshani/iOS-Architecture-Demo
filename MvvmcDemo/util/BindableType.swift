//
//  BindableType.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 4/14/20.
//  Copyright © 2020 arblitroshani. All rights reserved.
//

import UIKit


protocol BindableType: AnyObject {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }

    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bind(to model: Self.ViewModelType, loadIfNeeded: Bool = true) {
        viewModel = model
        if loadIfNeeded {
            loadViewIfNeeded()
        }
        bindViewModel()
    }
}

extension BindableType where Self: UITableViewCell {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}

extension BindableType where Self: UICollectionViewCell {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        bindViewModel()
    }
}
