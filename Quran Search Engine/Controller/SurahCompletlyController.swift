//
//  SurahCompletlyController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 17.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class SurahCompletlyController: UIViewController {

    var volatileNumber: Int = 0
    var service = ServiceData.shared
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }

    fileprivate func loadData() {
        service.fetchSurahById(surahId: volatileNumber) { (result) in
            self.textView.text = result
        }
    }

}
