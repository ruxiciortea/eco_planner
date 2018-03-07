//
//  UITextFieldExtension.swift
//  eco_planner
//
//  Created by user on 13/02/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

extension UITextField {
    @IBInspectable var placeholderColor: UIColor {
        get {
            return attributedPlaceholder?.attribute(.foregroundColor, at: 0, effectiveRange: nil) as? UIColor ?? UIColor.clear
        }
        set {
            guard let attributedPlaceholder = attributedPlaceholder else { return }
            let attributes: [NSAttributedStringKey : UIColor] = [.foregroundColor : newValue]
            self.attributedPlaceholder = NSAttributedString(string: attributedPlaceholder.string, attributes: attributes)
        }
    }
}
