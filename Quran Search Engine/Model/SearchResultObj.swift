//
//  SearchResultObj.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import Foundation

class SearchResultObj {
    
    var surahName: String?
    var surahNumber: Int?
    var ayahNumber: Int?
    var ayahText: String?
    
    init() {}
    
    init?(suraNum: Int, suraName: String, ayaNumber: Int, ayaText: String) {
        self.surahName = suraName
        self.surahNumber = suraNum
        self.ayahNumber = ayaNumber
        self.ayahText = ayaText
    }
    
    func toString() {
        print("Surah number : \(String(describing: self.surahNumber)), Surah name : \(String(describing: self.surahName)), Ayah number : \(String(describing: self.ayahNumber)), ayah text : \(String(describing: self.ayahText))")
    }
}
