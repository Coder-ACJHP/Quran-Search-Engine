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
    
    typealias SEARCH_RESULT_DATA = ([String]) -> ()
    typealias SEARCH_RESULT_DATA_WITH_INDEX = (SearchResultObj) -> ()
    
    static let shared = ServiceData()
    var stringArray = [String]()
    var filePath = ""
    
    init() {
        
        filePath = Bundle.main.path(forResource: "Quran", ofType: "txt")!
    }
    
    func findByWordWithIndex(query: String, completionHandler: SEARCH_RESULT_DATA_WITH_INDEX) {
        let resultList = SearchResultObj()
        let reader = FileReader(path: filePath)
        
        for singleLine in reader! {
            // Add your logic here
        }
        completionHandler(resultList)
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
        let okayChars = Set("ا ب ت ث ج ح خ د ذ ر ز س ش ص ض ط ظ ع غ ف ق ك ل م ن ه و ي ء ة ئ ى إ")
        return text.filter {okayChars.contains($0) }
    }
}
