//
//  SurahCompletlyController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 17.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import MBProgressHUD

class SurahCompletlyController: UIViewController {

    var menuIsAppear = false
    var volatileNumber: Int = 0
    var service = ServiceData.shared
    // Create animated indicator instance
    var spinnerActivity: MBProgressHUD?
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var backgroundSlider: UISlider!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var biggerFontIcon: UILabel!
    @IBOutlet weak var smallerFontIcon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideElementsBeforeLoad()
        
        // make slider corner radius
        backgroundSlider.layer.cornerRadius = 5
        
        // Load data from api
        loadData()
    }

    fileprivate func hideElementsBeforeLoad() {
        // Hide menu at start
        self.stackView.alpha = 0
    }
    
    fileprivate func loadData() {
        
        // Initialize spinner (MBHUD)
        spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        // Change some properties of spinner
        spinnerActivity?.label.text = "جاري التحميل"
        spinnerActivity?.isUserInteractionEnabled = true
        service.fetchSurahById(surahId: volatileNumber) { (result) in
            self.textView.text = result
        }
        self.spinnerActivity?.hide(animated: true, afterDelay: 0.5)
    }

    @IBAction func fontSizeChanged(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        textView.font = UIFont(name: "Damascus", size: fontSize)
    }
    
    @IBAction func menuButton(_ sender: Any) {
        if menuIsAppear {
            hideMenu()
        } else {
            showMenu()
        }
        menuIsAppear = !menuIsAppear
    }
    
    fileprivate func showMenu() {
        
        UIView.animate(withDuration: 0.5) {
            self.stackView.alpha = 1
        }
    }
    
    fileprivate func hideMenu() {
        UIView.animate(withDuration: 0.5) {
            self.stackView.alpha = 0
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        shadowView.backgroundColor = shadowView.backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
}





