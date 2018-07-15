//
//  ServiceData.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import Foundation
import UIKit


class ServiceData {
    
    let specialCharacters = "| 1234567890"
    let arabicAlphabet = "ا ب ت ث ج ح خ د ذ ر ز س ش ص ض ط ظ ع غ ف ق ك ل م ن ه و ي ء ة ئ ى إ"
    typealias SEARCH_RESULT_DATA = ([String]) -> ()
    typealias SEARCH_RESULT_DATA_WITH_INDEX = (SearchResultObj) -> ()
    
    static let shared = ServiceData()
    var stringArray = [String]()
    var filePath = ""
    
    init() {
        
        filePath = Bundle.main.path(forResource: "Quran", ofType: "txt")!
    }
    
    func findByWordWithIndex(query: String, selectedIndex: Int, completionHandler: SEARCH_RESULT_DATA_WITH_INDEX) {
        let resultList = SearchResultObj()
        let reader = FileReader(path: filePath)
        
        var counter = 0
        for singleLine in reader! {
            if singleLine.contains(query) {
                
                if counter == selectedIndex {
                    // First remove all text from line
                    let verseAndSurahNumber = removeTextFromString(text: singleLine)
                    // Split numbers to get verse & surah numbers
                    let numbersArray = verseAndSurahNumber.split(separator: "|")
                    // First element is verse number
                    let numberOne = String(numbersArray[0])
                    resultList.surahNumber = Int(numberOne)
                    // Second is surah number
                    let numberTwo = numbersArray[1]
                    resultList.ayahNumber = Int(numberTwo)
                    
                    
                }
                counter = counter + 1
            }
        }
        completionHandler(resultList)
        print("[")
        for index in 1...114 {
            print("\"\(index)\":\"\",")
        }
        print("]")
    }
    
    func findByWord(query: String, completionHandler: SEARCH_RESULT_DATA) {

        var resultList = [String]()
        let reader = FileReader(path: filePath)
        
        for line in reader! {
            if line.contains(query) {
                let pureArabicText = removeSpecialCharsFromString(text: line)
                resultList.append(pureArabicText)
            }
        }
        completionHandler(resultList)
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set(arabicAlphabet)
        return text.filter {okayChars.contains($0) }
    }
    
    func removeTextFromString(text: String) -> String {
        let acceptedChars = Set(specialCharacters)
        return text.filter {acceptedChars.contains($0)}
    }
}
