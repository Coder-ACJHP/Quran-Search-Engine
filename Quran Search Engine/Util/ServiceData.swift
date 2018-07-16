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
    
    let data = DataSource.shared
    let specialCharacters = "|1234567890"
    let arabicAlphabet = "ا ب ت ث ج ح خ د ذ ر ز س ش ص ض ط ظ ع غ ف ق ك ل م ن ه و ي ء ة ئ ى إ"
    typealias SEARCH_RESULT_DATA = ([String]) -> ()
    typealias SEARCH_RESULT_DATA_WITH_INDEX = (SearchResultObj) -> ()
    
    static let shared = ServiceData()
    var stringArray = [String]()
    var filePath = ""
    
    init() {
        
        filePath = Bundle.main.path(forResource: "Quran", ofType: "txt")!
    }
    
    func findByWordWithIndex(query: String, selectedIndex: Int, completionHandler: @escaping SEARCH_RESULT_DATA_WITH_INDEX) {
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
                    let surahNumber = String(numbersArray[0])
                    resultList.surahNumber = Int(surahNumber)!
                    // Second is surah number
                    let ayahNumber = numbersArray[1]
                    //Get surah name from the list
                    resultList.ayahNumber = Int(ayahNumber)!
                    
                }
                counter = counter + 1
            }
        }
        completionHandler(resultList)
    }
    
    func findByWord(query: String, completionHandler: @escaping SEARCH_RESULT_DATA) {

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
    
    public func findOthmaniAyahTextById(ayahNumber: Int, surahNumber: Int, completion: @escaping SEARCH_RESULT_DATA_WITH_INDEX) {
        let searchQuery = String(surahNumber) + ":" + String(ayahNumber)
        let apiUrl = URL(string: "http://api.alquran.cloud/ayah/" + searchQuery)
        let session = URLSession.shared
        
        let task = session.dataTask(with: apiUrl!) { (data, response, error) in
            
            if error != nil {
                self.showConnectionError()
            } else {
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, AnyObject>
                    DispatchQueue.main.sync {
                        
                        let searchObj = SearchResultObj()
                        
                        let data = result["data"]
                        if let juz = data!["juz"] as? Int {
                            searchObj.juz = juz
                        }
                        
                        if let surahDetail = data!["surah"] as? Dictionary<String, AnyObject> {
                            if let surahNumber = surahDetail["number"] as? Int {
                                searchObj.surahNumber = surahNumber
                            }
                            if let surahArabicName = surahDetail["name"] as? String {
                                searchObj.surahName = surahArabicName
                            }
                            if let surahRevType = surahDetail["revelationType"] as? String {
                                searchObj.revelationType = surahRevType
                            }
                        }
                        if let ayahText = data!["text"] as? String {
                            searchObj.ayahText = ayahText
                        }
                        if let ayahNumber = data!["numberInSurah"] as? Int {
                            searchObj.ayahNumber = ayahNumber
                        }
                        
                        completion(searchObj)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        task.resume()
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set(arabicAlphabet)
        return text.filter {okayChars.contains($0) }
    }
    
    func removeTextFromString(text: String) -> String {
        let acceptedChars = Set(specialCharacters)
        return text.filter {acceptedChars.contains($0)}
    }
    
    fileprivate func getSurahName(surahNumberAsString: Int) -> String {
        let convertIntToString = String(surahNumberAsString)
        return self.data.quranSurahIndex[convertIntToString]!
    }
    
    func showConnectionError() {
        let alert = UIAlertController(title: "عذراً", message: "يبدو ان الاتصال بالانترنت غير متوفر حالياً", preferredStyle: UIAlertControllerStyle.alert)
        let cancelButton = UIAlertAction(title: "تَخَطَّى", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelButton)
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.present(alert, animated: true, completion: nil)
    }
}
