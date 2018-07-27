//
//  DetailController.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 15.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    
    var ayahNumber: Int?
    var surahNumber: Int?
    let service = ServiceData.shared
    @IBOutlet weak var ayahNumberLabel: UILabel!
    @IBOutlet weak var ayahtextLabel: UITextView!
    @IBOutlet weak var surahNumberlabel: UILabel!
    @IBOutlet weak var surahNameLabel: UILabel!
    @IBOutlet weak var landingPlaceLabel: UILabel!
    @IBOutlet weak var juzNumberLabel: UILabel!
    @IBOutlet weak var backgroundWallpaper: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add motion effect
        backgroundWallpaper.moveViaMotionEffect()
        
        loadData()
     }

    fileprivate func loadData() {
            
        service.findOthmaniAyahTextById(ayahNumber: self.ayahNumber!, surahNumber: self.surahNumber!) { (resultObj) in
                    
            self.ayahNumberLabel.text = String(resultObj.ayahNumber).replaceEnglishDigitsWithArabic
            self.ayahtextLabel.text = resultObj.ayahText
            self.surahNameLabel.text = resultObj.surahName
            self.surahNumberlabel.text = String(resultObj.surahNumber).replaceEnglishDigitsWithArabic
            self.juzNumberLabel.text = String(resultObj.juz).replaceEnglishDigitsWithArabic
            if resultObj.revelationType == "Medinan" {
                self.landingPlaceLabel.text = "مدينة"
            } else {
                self.landingPlaceLabel.text = "مكة"
            }
            
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
