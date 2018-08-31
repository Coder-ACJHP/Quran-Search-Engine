//
//  AcknowledgmentController.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 31.08.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class AcknowledgmentController: UIViewController {

    @IBOutlet weak var dismissBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissBtn.layer.cornerRadius = 5.0
    }
    
    @IBAction func mbProgressButon(_ sender: Any) {
        if let url = URL(string: "https://github.com/jdg/MBProgressHUD") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func islamicNetworkButton(_ sender: Any) {
        if let url = URL(string: "https://alquran.cloud/terms-and-conditions") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func tanzilButton(_ sender: Any) {
        if let url = URL(string: "http://tanzil.net/docs/text_license") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func dismissBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
