//
//  DetailController.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 15.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    
    var searchObj: SearchResultObj?
    @IBOutlet weak var ayahNumberLabel: UILabel!
    @IBOutlet weak var ayahtextLabel: UILabel!
    @IBOutlet weak var surahNumberlabel: UILabel!
    @IBOutlet weak var surahNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }


    fileprivate func loadData() {
        
        if searchObj != nil {
            self.ayahtextLabel.text = searchObj?.ayahText
            self.ayahNumberLabel.text = String(describing: searchObj?.ayahNumber)
            self.surahNameLabel.text = searchObj?.surahName
            self.surahNumberlabel.text = String(describing: searchObj?.surahNumber)
        }
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
}
