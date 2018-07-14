//
//  ResultTableCell.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class ResultTableCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textLabel?.numberOfLines = 2
        self.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.textLabel?.textAlignment = .right
    }
    
}

extension UILabel {
    
    func chageColorOfText(lineOfText: String, text: String, color: UIColor) {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: lineOfText)
        attributedString.setColorForText(textForAttribute: text, withColor: color)
        self.attributedText = attributedString
    }
}

extension NSMutableAttributedString {
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: range)
        self.addAttribute(NSAttributedStringKey.font, value: UIFont.boldSystemFont(ofSize: 17.0), range: range)
    }
}
