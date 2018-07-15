//
//  ViewController.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {

    var fixedText = ""
    var searchQuery = ""
    var menuIsShown = false
    var searchObject = SearchResultObj()
    let data = ServiceData.shared
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var sideMenuLeadingConstrait: NSLayoutConstraint!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var searchResultLabel: UILabel!
    
    // Create animated indicator instance
    var spinnerActivity: MBProgressHUD?
    
    // Set custom color
    let darkGreen = UIColor(red:0.00, green:0.57, blue:0.54, alpha:1.0)
    
    // Search result will collect here
    var resultlist = [String]()
    
    // Shadow layer will use when side menu appear
    var blackViewConstrains = [NSLayoutConstraint]()
    let blackView: UIView = {
        let shadow = UIView()
        shadow.backgroundColor = UIColor(white: 0, alpha: 0.5)
        shadow.frame.size = CGSize(width: 375, height: 690)
        shadow.translatesAutoresizingMaskIntoConstraints = false
        return shadow
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ////////////////////////////////////////////////
        //Setup shadow layer (view) and set constraits//
        ////////////////////////////////////////////////
        let leadingConstraint = blackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = blackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let topConstraint = blackView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let bottomConstraint = blackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -34)
        blackViewConstrains.append(contentsOf: [leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        view.addSubview(blackView)
        NSLayoutConstraint.activate(blackViewConstrains)
        blackView.isHidden = true
        
        // Get default text for label
        fixedText = searchResultLabel.text!
        
        //////////////////////////////////////////////////////
        //Adjust tables & searchbar delegate and dataSources//
        //////////////////////////////////////////////////////
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        
        resultTable.delegate = self
        resultTable.dataSource = self
        
        searchbar.delegate = self
        
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        if menuIsShown {
            hideMenu()
        } else {
            showMenu()
        }
        menuIsShown = !menuIsShown
    }
    
    fileprivate func showMenu() {
        //Show menu
        sideMenuLeadingConstrait.constant = 0
        // Show black view
        blackView.isHidden = false
        
        // animate opening of the menu - including opacity value
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            // bring menu to front
            self.view.bringSubview(toFront: self.sideMenu)
        }
    }
    
    fileprivate func hideMenu() {
        // Hide menu
        sideMenuLeadingConstrait.constant = (self.sideMenuLeadingConstrait.constant - self.sideMenu.frame.size.width)
        // Hide black view
        blackView.isHidden = true
        
        // animate opening of the menu - including opacity value
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailViewController" {
            let destinationViewController = segue.destination as? DetailController
            destinationViewController?.searchObj = self.searchObject
        }
    }
    
}

// Delegate and manage data of table view here
extension ViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnVal = 0
        
        // We have two table thats why firt we have to choose which tabel working here
        if tableView == self.sideMenuTableView {
            returnVal = DataSource.shared.textArray.count
        } else if tableView == self.resultTable {
            returnVal =  resultlist.count
        }
        return returnVal
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var menuCell:SideMenuCell?
        var resultCell:ResultTableCell?
        
        if tableView == self.sideMenuTableView {
            menuCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? SideMenuCell
            menuCell?.cellTextLabel?.text = DataSource.shared.textArray[indexPath.row]
            menuCell?.imageContainer?.image = DataSource.shared.imageArray[indexPath.row]
            return menuCell!
            
        } else {
            
            resultCell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultTableCell
            //resultCell?.textLabel?.text = resultlist[indexPath.row]
            let resultLine = resultlist[indexPath.row]
            resultCell?.textLabel?.chageColorOfText(lineOfText: resultLine, text: searchQuery, color: UIColor.red)
            return resultCell!
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.resultTable {
            data.findByWordWithIndex(query: searchQuery, selectedIndex: indexPath.row) { (searchObj) in
                self.searchObject = searchObj
                self.performSegue(withIdentifier: "toDetailView", sender: self)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == " " || searchText.isEmpty {
            // Change color to red because no result
            self.searchResultLabel.textColor = UIColor.red
            // Set the original text to label
            self.searchResultLabel.text = fixedText
            // Clean list from old results
            resultlist.removeAll(keepingCapacity: false)
            resultTable.reloadData()
        } else {
            // Keep the query text
            self.searchQuery = searchText
            // Clean the list for staying away from duplicate elements thats remain from old result
            resultlist.removeAll(keepingCapacity: false)
            
            // Initialize spinner (MBHUD)
            spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
            // Change some properties of spinner
            spinnerActivity?.label.text = "جاري البحث"
            spinnerActivity?.isUserInteractionEnabled = true
            self.data.findByWord(query: searchText) { (resultArray) in
                // Add result list that coming from search result to local result list
                self.resultlist = resultArray
                // Change some property of text label
                self.searchResultLabel.textColor = self.darkGreen
                let numberAsString = String(self.resultlist.count)
                self.searchResultLabel.text = "تم العثور على \(numberAsString.replaceEnglishDigitsWithArabic) أية"
            }
            self.resultTable.reloadData()
            self.spinnerActivity?.hide(animated: true, afterDelay: 1.0)
        }
    }
    
}





