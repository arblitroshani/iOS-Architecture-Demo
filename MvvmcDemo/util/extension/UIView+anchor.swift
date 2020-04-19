//
//  UIView+anchor.swift
//  MvvmcDemo
//
//  Created by Arbli Troshani on 10/7/19.
//  Adapted from https://github.com/bhlvoong/LBTAComponents/
//  Copyright © 2019 arblitroshani. All rights reserved.
//

import UIKit


public enum LayoutReference {
    case safeArea
    case layoutMargins
}


extension UIView {

    public func fillSuperview(constant: CGFloat = 0, ref: LayoutReference = .safeArea) {
        fillSuperview(verticalConstant: constant, horizontalConstant: constant, ref: ref)
    }

    public func fillSuperview(verticalConstant: CGFloat = 0, horizontalConstant: CGFloat = 0, ref: LayoutReference = .safeArea) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }

        let reference: UILayoutGuide = ref == .layoutMargins ? superview.layoutMarginsGuide : superview.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: reference.topAnchor, constant: verticalConstant),
            leadingAnchor.constraint(equalTo: reference.leadingAnchor, constant: horizontalConstant),
            bottomAnchor.constraint(equalTo: reference.bottomAnchor, constant: -verticalConstant),
            trailingAnchor.constraint(equalTo: reference.trailingAnchor, constant: -horizontalConstant)
        ])
    }

    public func anchor(
        top:      NSLayoutYAxisAnchor? = nil, topConstant:      CGFloat = 0,
        leading:  NSLayoutXAxisAnchor? = nil, leadingConstant:  CGFloat = 0,
        bottom:   NSLayoutYAxisAnchor? = nil, bottomConstant:   CGFloat = 0,
        trailing: NSLayoutXAxisAnchor? = nil, trailingConstant: CGFloat = 0,
        centerX:  NSLayoutXAxisAnchor? = nil, centerXConstant:  CGFloat = 0,
        centerY:  NSLayoutYAxisAnchor? = nil, centerYConstant:  CGFloat = 0,
        width: NSLayoutDimension? = nil, widthConstant:  CGFloat = 0,
        heightConstant: CGFloat = 0)
    {
        _ = anchorWithReturnAnchors(
            top: top, topConstant: topConstant,
            leading: leading, leadingConstant: leadingConstant,
            bottom: bottom, bottomConstant: bottomConstant,
            trailing: trailing, trailingConstant: trailingConstant,
            centerX: centerX, centerXConstant: centerXConstant,
            centerY: centerY, centerYConstant: centerYConstant,
            width: width, widthConstant: widthConstant,
            heightConstant: heightConstant)
    }

    public func anchorWithReturnAnchors(
        top:      NSLayoutYAxisAnchor? = nil, topConstant:      CGFloat = 0,
        leading:  NSLayoutXAxisAnchor? = nil, leadingConstant:  CGFloat = 0,
        bottom:   NSLayoutYAxisAnchor? = nil, bottomConstant:   CGFloat = 0,
        trailing: NSLayoutXAxisAnchor? = nil, trailingConstant: CGFloat = 0,
        centerX:  NSLayoutXAxisAnchor? = nil, centerXConstant:  CGFloat = 0,
        centerY:  NSLayoutYAxisAnchor? = nil, centerYConstant:  CGFloat = 0,
        width: NSLayoutDimension? = nil, widthConstant:  CGFloat = 0,
        heightConstant: CGFloat = 0) -> [NSLayoutConstraint]
    {
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()

        if let top = top { anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant)) }
        if let leading = leading { anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant)) }
        if let bottom = bottom { anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)) }
        if let trailing = trailing { anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant)) }
        if let centerX = centerX { anchors.append(centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant)) }
        if let centerY = centerY { anchors.append(centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant)) }
        if let width = width {
            anchors.append(widthAnchor.constraint(equalTo: width, multiplier: 1.0, constant: widthConstant))
        } else if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 { anchors.append(heightAnchor.constraint(equalToConstant: heightConstant)) }

        anchors.forEach { $0.isActive = true }
        return anchors
    }

    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }

    public func anchorLeadingSuperview(constant: CGFloat = 0, ref: LayoutReference = .safeArea) {
        guard let superview = superview else { return }
        let reference = ref == .layoutMargins ? superview.layoutMarginsGuide : superview.safeAreaLayoutGuide
        anchor(
            top: reference.topAnchor, topConstant: constant,
            leading: reference.leadingAnchor, leadingConstant: constant,
            bottom: reference.bottomAnchor, bottomConstant: constant)
    }

    public func anchorTrailingSuperview(constant: CGFloat = 0, ref: LayoutReference = .safeArea) {
        guard let superview = superview else { return }
        let reference = ref == .layoutMargins ? superview.layoutMarginsGuide : superview.safeAreaLayoutGuide
        anchor(
            top: reference.topAnchor, topConstant: constant,
            bottom: reference.bottomAnchor, bottomConstant: constant,
            trailing: reference.trailingAnchor, trailingConstant: constant)
    }

    public func anchorTopSuperview(constant: CGFloat = 0, ref: LayoutReference = .safeArea) {
        guard let superview = superview else { return }
        let reference = ref == .layoutMargins ? superview.layoutMarginsGuide : superview.safeAreaLayoutGuide
        anchor(
            top: reference.topAnchor, topConstant: constant,
            leading: reference.leadingAnchor, leadingConstant: constant,
            trailing: reference.trailingAnchor, trailingConstant: constant)
    }

    public func anchorBottomSuperview(constant: CGFloat = 0, ref: LayoutReference = .safeArea) {
        guard let superview = superview else { return }
        let reference = ref == .layoutMargins ? superview.layoutMarginsGuide : superview.safeAreaLayoutGuide
        anchor(
            leading: reference.leadingAnchor, leadingConstant: constant,
            bottom: reference.bottomAnchor, bottomConstant: constant,
            trailing: reference.trailingAnchor, trailingConstant: constant)
    }

    public func anchorTopTrailingSuperview(constant: CGFloat = 0, ref: LayoutReference = .safeArea) {
        guard let superview = superview else { return }
        let reference = ref == .layoutMargins ? superview.layoutMarginsGuide : superview.safeAreaLayoutGuide
        anchor(
            top: reference.topAnchor, topConstant: constant,
            trailing: reference.trailingAnchor, trailingConstant: constant)
    }

    public func anchorTopLeadingSuperview(constant: CGFloat = 0, ref: LayoutReference = .safeArea) {
        guard let superview = superview else { return }
        let reference = ref == .layoutMargins ? superview.layoutMarginsGuide : superview.safeAreaLayoutGuide
        anchor(
            top: reference.topAnchor, topConstant: constant,
            leading: reference.leadingAnchor, leadingConstant: constant)
    }

    public func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }

    public func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

    @discardableResult
    open func withSize<T: UIView>(_ size: CGSize) -> T {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self as! T
    }

    @discardableResult
    open func withHeight(_ height: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }

    @discardableResult
    open func withWidth(_ width: CGFloat) -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
}
