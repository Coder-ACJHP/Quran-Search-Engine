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
    
    @IBAction func sheetMenu(_ sender: Any) {
        
        let verse = self.ayahtextLabel.text
        
        let optionMenu = UIAlertController(title: nil, message: "Choose option", preferredStyle: UIAlertControllerStyle.actionSheet)
        let copyToClipboard = UIAlertAction(title: "نسخ إلى الحافظة", style: UIAlertActionStyle.default) { (action) in
            UIPasteboard.general.string = verse
        }
        let shareTheVerse = UIAlertAction(title: "شارك الآية", style: UIAlertActionStyle.default) { (action) in
            
            let activityController = UIActivityViewController(activityItems: [verse as Any], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "إلغاء الأمر", style: UIAlertActionStyle.cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        optionMenu.addAction(copyToClipboard)
        optionMenu.addAction(shareTheVerse)
        optionMenu.addAction(cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
}
