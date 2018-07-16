//
//  SearchResultObj.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import Foundation

class SearchResultObj {
    
    var juz: Int = 0
    var revelationType: String = ""
    var surahName: String = ""
    var surahNumber: Int = 0
    var ayahNumber: Int = 0
    var ayahText: String = ""
    
    init() {}
    
    init?(juz: Int, suraNum: Int, suraName: String, revType: String, ayaNumber: Int, ayaText: String) {
        self.surahName = suraName
        self.surahNumber = suraNum
        self.ayahNumber = ayaNumber
        self.ayahText = ayaText
        self.juz = juz
        self.revelationType = revType
    }
    
    func toString() {
        print("Juz number : \(self.juz), Revulation type : \(self.revelationType), Surah number : \(self.surahNumber), Surah name : \(self.surahName), Ayah number : \(self.ayahNumber), ayah text : \(self.ayahText)")
    }
}
