//
//  RoundButton.swift
//  EcoPlanner
//
//  Created by user on 07/06/2018.
//  Copyright © 2018 Ruxi. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        addTarget(self, action: #selector(RoundButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        self.activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        isOn = bool
        
        let color = bool ? kBlueColor : .clear
        self.backgroundColor = color
        
        let textColor = bool ? kLightGreenColor : kBlueColor
        self.setTitleColor(textColor, for: .normal)
    }
    
}
