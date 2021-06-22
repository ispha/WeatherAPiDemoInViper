//
//  CustomUiElements.swift
//  MusalaTask
//
//  Created by ispha on 21/06/2021.
//  Copyright © 2021 ispha. All rights reserved.
//

import  UIKit
@IBDesignable class DesignableButton: UIButton {
    @IBInspectable lazy var isRoundRectButton: Bool = false
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    //  MARK:   Awake From Nib
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet{
            setUpView()
        }
    }
    
    func setUpView() {
        if isRoundRectButton {
            self.layer.cornerRadius = self.bounds.height / 2
            self.clipsToBounds = true
        } else {
            self.layer.cornerRadius = self.cornerRadius
            self.clipsToBounds = true
        }
    }
}
