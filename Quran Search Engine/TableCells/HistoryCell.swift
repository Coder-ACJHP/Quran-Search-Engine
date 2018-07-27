//
//  HistoryCell.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 27.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel?.textColor = UIColor.gray
        textLabel?.font = UIFont(name: "DamascusMedium", size: 20)
        textLabel?.textAlignment = .left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
