//
//  TextField.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 1.08.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class TextField: UITextField {

    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
    }

}
