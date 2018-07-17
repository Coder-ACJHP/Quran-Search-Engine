//
//  SearchCell.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 17.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var surahNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 5
    }
}
