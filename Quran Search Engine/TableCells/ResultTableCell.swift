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



