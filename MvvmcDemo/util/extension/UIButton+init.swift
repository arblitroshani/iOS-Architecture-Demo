//
//  UIButton+init.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 10/7/19.
//  Copyright © 2019 arblitroshani. All rights reserved.
//

import UIKit


extension UIButton {

    convenience public init(
        title: String = "",
        titleColor: UIColor = .black,
        font: UIFont = .systemFont(ofSize: 14),
        backgroundColor: UIColor = .clear,
        target: Any? = nil,
        action: Selector? = nil)
    {
        self.init(type: .system)
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        self.backgroundColor = backgroundColor

        if let action = action {
            addTarget(target, action: action, for: .touchUpInside)
        }
    }

    convenience public init(image: UIImage, tintColor: UIColor? = nil) {
        self.init(type: .system)
        if tintColor == nil {
            setImage(image, for: .normal)
        } else {
            setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
            self.tintColor = tintColor
        }
    }
}
