//
//  DesignableUISlider.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 23.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableUISlider: UISlider {
    
    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
    @IBInspectable var thumbHighlightedImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .highlighted)
        }
    }
}
