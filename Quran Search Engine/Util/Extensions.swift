//
//  Extensions.swift
//  Quran Search Engine
//
//  Created by Onur Işık on 30.08.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

// Extensions for coloring words in text line
extension UITextView {
    
    func changeFontSize(size: CGFloat) {
        let customFont = UIFont(name: "DamascusSemiBold", size: size)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 15
        style.alignment = .center
        let attributes = [
            NSAttributedStringKey.paragraphStyle : style,
            NSAttributedStringKey.font : customFont!,
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]
        self.attributedText = NSAttributedString(string: self.text, attributes: attributes)
    }
}

extension UILabel {
    
    func chageColorOfText(lineOfText: String, text: String, color: UIColor) {
        let attributedString = NSMutableAttributedString(string: lineOfText)
        attributedString.setColorForText(textForAttribute: text, withColor: color)
        self.attributedText = attributedString
    }
}

extension NSMutableAttributedString {
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        let usedFont = UIFont(name: "DamascusSemiBold", size: 19.0)
        self.addAttribute(NSAttributedStringKey.font, value: usedFont!, range: range)
    }
}

extension UIColor {
    // Set custom color
    static let customGreen = UIColor.init(red: 99 / 255, green: 155 / 255, blue: 177 / 255, alpha: 1.0)
}
