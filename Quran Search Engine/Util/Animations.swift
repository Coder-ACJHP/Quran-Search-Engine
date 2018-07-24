//
//  Animations.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 24.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class Animations: NSObject {
    
    static var shared = Animations()
    
    // Lets create animation that allow to stuff cells from down to up one by one
    func animateTableCells(table: UITableView) {
        table.reloadData()
        
        let cells = table.visibleCells
        let tableHeight: CGFloat = table.bounds.size.height
        
        for counter in cells {
            let cell: UITableViewCell = counter as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for cellCounter in cells {
            let cell: UITableViewCell = cellCounter as UITableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            
            index += 1
        }
    }
}
