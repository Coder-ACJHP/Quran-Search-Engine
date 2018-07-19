//
//  SurahCompletlyController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 17.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class SurahCompletlyController: UIViewController {

    var menuIsAppear = false
    var volatileNumber: Int = 0
    var service = ServiceData.shared
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var biggerFontIcon: UILabel!
    @IBOutlet weak var smallerFontIcon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideElementsBeforeLoad()
        
        // Load data from api
        loadData()
    }

    fileprivate func hideElementsBeforeLoad() {
        // Hide menu at start
        self.stackView.alpha = 0
    }
    
    fileprivate func loadData() {
        service.fetchSurahById(surahId: volatileNumber) { (result) in
            self.textView.text = result
        }
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
}





