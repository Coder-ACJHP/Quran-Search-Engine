//
//  EnglishNumberToArabic.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import Foundation

public extension String {
    
    public var replaceEnglishDigitsWithArabic: String {
        var str = self
        let map = ["0": "٠" ,
                   "1": "١",
                   "2": "٢",
                   "3": "٣",
                   "4": "٤",
                   "5": "٥",
                   "6": "٦",
                   "7": "٧",
                   "8": "٨",
                   "9": "٩"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
}
