//
//  CustomCell.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var cellTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Make background color clear
        self.backgroundColor = UIColor.clear

        imageContainer.contentMode = .scaleToFill
        imageContainer.layer.cornerRadius = 5
        imageContainer.clipsToBounds = true
    }

}
