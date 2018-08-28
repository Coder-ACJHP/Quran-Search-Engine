//
//  FeedbackController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 16.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackController: UIViewController {

    var issueNameFieldTrimmed = String()
    var issueDetailFieldTrimmed = String()
    let recieverAddress = "hexa.octabin@gmail.com"
    @IBOutlet weak var issueNameField: UITextField!
    @IBOutlet weak var issueDetailField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var backgroundWallpaper: UIImageView!
    @IBOutlet weak var container: UIView!
    let blueColor = UIColor.init(red: 0 / 255, green: 150 / 255, blue: 255 / 255, alpha: 1.0)
    let redColor = UIColor.init(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        handleKeyboardDismiss()
        giveRadiusToComponents()
        issueNameField.addTarget(self, action: #selector(FeedbackController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        issueDetailField.addTarget(self, action: #selector(FeedbackController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        validateFields()
    }
    
    private func giveRadiusToComponents() {
        self.issueNameField.layer.cornerRadius = 3.0
        self.issueDetailField.layer.cornerRadius = 3.0
        self.sendButton.layer.cornerRadius = 3.0
    }
    
    private func validateFields() {
        
        // Remove white spaces and lines
        issueNameFieldTrimmed = (issueNameField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        issueDetailFieldTrimmed = (issueDetailField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        // Validate texts is empty or shorter than desired
        if issueNameFieldTrimmed != "" && issueDetailFieldTrimmed != "" &&
            issueNameFieldTrimmed.count > 5 && issueDetailFieldTrimmed.count > 5 {
            
            sendButton.addTarget(self, action: #selector(sendButtonPressed(_:)), for: .touchUpInside)
            sendButton.backgroundColor = blueColor
            sendButton.layer.borderColor = blueColor.cgColor
            self.issueNameField.layer.borderColor = blueColor.cgColor
            self.issueDetailField.layer.borderColor = blueColor.cgColor
            
        } else {
            
            sendButton.removeTarget(self, action: #selector(sendButtonPressed(_:)), for: .touchUpInside)
            sendButton.backgroundColor = redColor
            sendButton.layer.borderColor = redColor.cgColor
            self.issueNameField.layer.borderColor = redColor.cgColor
            self.issueDetailField.layer.borderColor = redColor.cgColor
        }
    }
    
    // Listen to tap gesture to hide keyboard
    private func handleKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FeedbackController.tapped))
        container.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapped() {
        self.view.endEditing(true)
    }
    
    
    @objc func sendButtonPressed(_ sender: Any) {
        if sendButton.backgroundColor == blueColor {
            sendEmail(subject: issueNameFieldTrimmed, detail: issueDetailFieldTrimmed)
        }
        // Hide the keyboard
        self.view.endEditing(true)
    }
    
    fileprivate func sendEmail(subject: String, detail: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject(subject)
            mail.setToRecipients([recieverAddress])
            mail.setMessageBody(detail, isHTML: false)
            
            present(mail, animated: true, completion: nil)
        
        } else {
            self.showError(title: "عذراً", message: "لا يمكن إرسال البريد حاليا! يرجى المحاولة مرة أخرى في وقت لاحق")
        }
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let cancelButton = UIAlertAction(title: "تَخَطَّى", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: {
            self.issueNameField.text = ""
            self.issueDetailField.text = ""
        })
    }
}

extension FeedbackController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
