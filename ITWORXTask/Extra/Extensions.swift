//
//  Extensions.swift
//  ITWORXTask
//
//  Created by Salwa Hegazy on 2/26/21.
//  Copyright © 2021 SalwaHegazy. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift
import MOLH
import NVActivityIndicatorView

@IBDesignable
class DesignableView: UIView {
}
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var MaskedCorners: String {
        get {
            return ""
        }
        set {
            layer.maskedCorners = []
            if newValue.contains("1") {
                layer.maskedCorners.update(with: .layerMaxXMinYCorner)
            }
            if newValue.contains("2") {
                layer.maskedCorners.update(with: .layerMinXMinYCorner)
            }
            if newValue.contains("3") {
                layer.maskedCorners.update(with: .layerMinXMaxYCorner)
            }
            if newValue.contains("4") {
                layer.maskedCorners.update(with: .layerMaxXMaxYCorner)
            }
        }
    }
}

