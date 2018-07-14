//
//  DataSource.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class DataSource {
    
    static let shared = DataSource()
    
    let imageArray = [UIImage(named: "read"), UIImage(named: "topic"), UIImage(named: "bug"), UIImage(named: "about")]
    let textArray = ["قرأن كامل", "تصفح المواضيع", "بلغنا عن مشكلة", "عنا"]
}
