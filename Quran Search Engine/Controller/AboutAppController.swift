//
//  AboutAppController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 16.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class AboutAppController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backgroundWallpaper: UIImageView!
    // Create animated indicator instance
    var spinnerActivity: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        // Get application version number and show it on label
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = version
        }
    
        webView.isHidden = true
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
        UIView.transition(with: webView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.webView.isHidden = false
        })
        
    }
    @IBAction func termsAndCondition(_ sender: Any) {
        loadPage(pageName: "terms")
        
        UIView.transition(with: webView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.webView.isHidden = false
        })
    }
    
    fileprivate func loadPage(pageName: String) {
        // Initialize spinner (MBHUD)
        spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        // Change some properties of spinner
        spinnerActivity?.label.text = "يرجى الأنتظار"
        spinnerActivity?.isUserInteractionEnabled = true
        let url = Bundle.main.url(forResource: pageName, withExtension: "html")
        webView.loadFileURL(url!, allowingReadAccessTo: url!)
    }
}

extension AboutAppController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.spinnerActivity?.show(animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinnerActivity?.hide(animated: true)
    }
}



