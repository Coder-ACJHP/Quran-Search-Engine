//
//  TempDatabase.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 25.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import Foundation

class TempDatabase {
    
    let defaultObjName = "historyList"
    static var shared = TempDatabase()
    
    func getHistoryList() -> [String] {
        let defaults = UserDefaults.standard
        return defaults.stringArray(forKey: defaultObjName) ?? [String]()
    }
    
    func saveHistoryList(list: Array<String>) {
        if list.count == 0 {
            return
        } else {
            let defaults = UserDefaults.standard
            defaults.set(list, forKey: defaultObjName)
        }
    }
}
