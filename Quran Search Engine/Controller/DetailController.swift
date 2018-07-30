//
//  DetailController.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 15.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import MBProgressHUD

class DetailController: UIViewController {

    
    // Entity object
    var searchObject = SearchResultObj()
    let service = ServiceData.shared
    // Create animated indicator instance
    var spinnerActivity: MBProgressHUD?
    @IBOutlet weak var ayahNumberLabel: UILabel!
    @IBOutlet weak var ayahtextLabel: UITextView!
    @IBOutlet weak var surahNumberlabel: UILabel!
    @IBOutlet weak var surahNameLabel: UILabel!
    @IBOutlet weak var landingPlaceLabel: UILabel!
    @IBOutlet weak var juzNumberLabel: UILabel!
    @IBOutlet weak var backgroundWallpaper: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
     }

    fileprivate func loadData() {
        
        // Initialize spinner (MBHUD)
        spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        // Change some properties of spinner
        spinnerActivity?.label.text = "جاري البحث"
        spinnerActivity?.isUserInteractionEnabled = true
        
        service.findOthmaniAyahTextById(ayahNumber: searchObject.ayahNumber, surahNumber: searchObject.surahNumber) { (resultObj) in
                    
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
        // Hide spinner
        self.spinnerActivity?.hide(animated: true, afterDelay: 1.0)
    }
    
    @IBAction func closePressed(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sheetMenu(_ sender: Any) {
        
        let verse = self.ayahtextLabel.text
        
        let optionMenu = UIAlertController(title: nil, message: "خيارات", preferredStyle: UIAlertControllerStyle.actionSheet)
        let copyToClipboard = UIAlertAction(title: "نسخ إلى الحافظة", style: UIAlertActionStyle.default) { (_) in
            UIPasteboard.general.string = verse
            self.showMessage(message: "تم النسخ الأية إلى الحافظة بنجاح")
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
    
    private func showMessage(message: String) {
        let alert = UIAlertController(title: "تم", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "تخطي", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
