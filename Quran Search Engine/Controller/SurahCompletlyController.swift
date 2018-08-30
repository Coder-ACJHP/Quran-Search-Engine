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

    var verseCount: Int!
    var keyboardSize: CGSize!
    var menuIsAppear = false
    var volatileNumber: Int = 0
    var isKeyboardAppear = false
    var service = ServiceData.shared
    // Create animated indicator instance
    var spinnerActivity: MBProgressHUD?
    let customFont = UIFont(name: "DamascusSemiBold", size: 24.0)
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var backgroundSlider: UISlider!
    @IBOutlet weak var contextualMenu: UIView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var biggerFontIcon: UILabel!
    @IBOutlet weak var smallerFontIcon: UILabel!
    @IBOutlet weak var backgroundWallpaper: UIImageView!
    @IBOutlet weak var goToVerseTextField: UITextField!
    @IBOutlet weak var contexualMenuBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerKeyboardNotifications()
        
        hideElementsBeforeLoad()
        
        // make slider corner radius
        backgroundSlider.layer.cornerRadius = 5
        
        // Load data from api
        loadData()
    }
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
        selector: #selector(keyboardWillShow(notification:)),
        name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(keyboardWillHide(notification:)),
        name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
            isKeyboardAppear = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
            isKeyboardAppear = false
        }
    }
    
    fileprivate func hideElementsBeforeLoad() {
        // Hide menu at start
        self.contextualMenu.isHidden = true
        self.contextualMenu.layer.cornerRadius = 7
    }
    
    fileprivate func loadData() {
        
        // Initialize spinner (MBHUD)
        spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        // Change some properties of spinner
        spinnerActivity?.label.text = "جاري التحميل"
        spinnerActivity?.isUserInteractionEnabled = true
        service.fetchSurahById(surahId: volatileNumber) { (versesText, surahName, totalVerseCount) in
            self.textView.text = versesText
            // Initialize the variables to use it in another function
            self.verseCount = totalVerseCount
            self.navigationItem.title = surahName
            self.spinnerActivity?.hide(animated: true, afterDelay: 0.5)
        }
        
    }

    @IBAction func fontSizeChanged(_ sender: UIStepper) {
        let fontSize = CGFloat(sender.value)
        textView.changeFontSize(size: fontSize)
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
        
        contextualMenu.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.contextualMenu.isHidden = false
            self.contextualMenu.transform = .identity
        }, completion: nil)
    }
    
    fileprivate func hideMenu() {
        UIView.animate(withDuration: 0.5) {
            self.contextualMenu.isHidden = true
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        shadowView.backgroundColor = shadowView.backgroundColor?.withAlphaComponent(CGFloat(sender.value))
    }
    
    @IBAction func goToVersePressed(_ sender: UIButton) {
        if let verseNumber = goToVerseTextField.text, !verseNumber.isEmpty {
            
            // Convert String to integer
            if let verseNumberAsInt = Int(verseNumber) {
                
                // Compare two numbers if entered number less than total verse number start to logic code
                if verseNumberAsInt <= self.verseCount {
                    
                    let verseNumber = verseNumber.replaceEnglishDigitsWithArabic
                    let substringRange = textView.text.range(of: verseNumber)!
                    let nsRange = NSRange(substringRange, in: textView.text)
                    transformToVerse { (isFinished) in
                        if isFinished {
                            UIView.animate(withDuration: 1.0) {
                                self.textView.scrollRangeToVisible(nsRange)
                            }
                        }
                    }
                } else {
                    let alertUser = UIAlertController(title: "!تحذير", message: "لم يتم العثور على أية رقم \(verseNumber)", preferredStyle: .alert)
                    alertUser.addAction(UIAlertAction(title: "تخطي", style: .cancel, handler: nil))
                    self.present(alertUser, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    fileprivate func transformToVerse(completionHandler: @escaping (Bool) -> Void) {
        self.goToVerseWithAnimations(completionHandler: { (isFinished) in
            if isFinished {
                completionHandler(true)
            }
        })
    }
    
    fileprivate func goToVerseWithAnimations(completionHandler: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut], animations: {
            self.view.frame.origin.y = 0
            self.view.endEditing(true)
        }) { (isFinished) in
            if isFinished {
                self.goToVerseTextField.text = ""
                self.hideMenu()
                completionHandler(true)
            }
        }
    }
}





