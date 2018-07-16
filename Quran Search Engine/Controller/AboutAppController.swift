//
//  AboutAppController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 16.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import WebKit

class AboutAppController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         loadPage(pageName: "privacy_policy")
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
    
    @IBAction func privacyButton(_ sender: Any) {
        loadPage(pageName: "privacy_policy")
    }
    @IBAction func termsAndCondition(_ sender: Any) {
        loadPage(pageName: "terms")
    }
    
    fileprivate func loadPage(pageName: String) {
        let url = Bundle.main.url(forResource: pageName, withExtension: "html")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
