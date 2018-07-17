//
//  FeedbackController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 16.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackController: UIViewController, MFMailComposeViewControllerDelegate {

    let recieverAddress = "hexa.octabin@gmail.com"
    @IBOutlet weak var issueNameField: UITextField!
    @IBOutlet weak var issueDetailField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendButton.layer.cornerRadius = 5
    }

    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
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
            self.showError()
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func showError() {
        let alert = UIAlertController(title: "عذراً", message: "لا يمكن إرسال البريد حاليا! يرجى المحاولة مرة أخرى في وقت لاحق", preferredStyle: UIAlertControllerStyle.alert)
        let cancelButton = UIAlertAction(title: "تَخَطَّى", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}