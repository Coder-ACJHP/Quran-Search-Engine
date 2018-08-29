//
//  ResultTableCell.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class ResultTableCell: UITableViewCell {
    
    @IBOutlet weak var surahNameLabel: UILabel!
    @IBOutlet weak var numberOfVerseLabel: UILabel!
    @IBOutlet weak var VerseTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.VerseTextLabel.numberOfLines = 2
        self.VerseTextLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.VerseTextLabel.textAlignment = .right
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
        let usedFont = UIFont(name: "Damascus", size: 19.0)
        self.addAttribute(NSAttributedStringKey.font, value: usedFont!, range: range)
    }
}
