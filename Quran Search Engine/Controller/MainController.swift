//
//  ViewController.swift
//  Quran Search Engine
//
//  Created by Coder ACJHP on 14.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainController: UIViewController {
    
    @IBOutlet weak var sideMenu: UIView!
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var sideMenuLeadingConstrait: NSLayoutConstraint!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var resultTable: UITableView!
    @IBOutlet weak var searchResultLabel: UILabel!
    @IBOutlet weak var searchResultView: UIVisualEffectView!
    @IBOutlet weak var roundedBgForresultLabel: UIView!
    @IBOutlet var tableViewBackground: UIView!
    @IBOutlet weak var tableAlertBackground: UIImageView!
    @IBOutlet weak var tableEmptyView: UIView!
    
    var fixedText = ""
    var searchQuery = ""
    var menuIsShown = false
    // Entity object
    var searchObject = SearchResultObj()
    // Api data service
    let data = ServiceData.shared
    // User defaults for saving history
    let defaults = TempDatabase.shared
    // Animation class instance
    let animations = Animations.shared
    // Create animated indicator instance
    var spinnerActivity: MBProgressHUD?
    // New Searchbar
    var searchController: UISearchController!
    // Set custom color
    let customGreen = UIColor.init(red: 99 / 255, green: 155 / 255, blue: 177 / 255, alpha: 1.0)
    // Search result will collect here
    var resultlist = [SearchResultObj]()
    // Searched keywords will collect here
    var searchKeywords = [String]()
    
    
    // Shadow layer will use when side menu appear
    var blackViewConstrains = [NSLayoutConstraint]()
    let blackView: UIView = {
        let shadow = UIView()
        shadow.backgroundColor = UIColor(white: 0, alpha: 0.7)
        shadow.frame.size = CGSize(width: 375, height: 690)
        shadow.translatesAutoresizingMaskIntoConstraints = false
        return shadow
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBlackShadowView()
        // Add logo image to navbar title view
        setupNavbarLogo()
        // Get default text for label
        fixedText = searchResultLabel.text!
        // Add border to result label holder
        searchResultView.layer.borderWidth = 0.75
        searchResultView.layer.borderColor = UIColor.lightGray.cgColor
        // Make label view rounded corners
        roundedBgForresultLabel.layer.cornerRadius = 6
        // Add swipe gesture to side menu
        addGestureToSideMenu()
        addEdgePanGestureToScreen()
        // Load history
        getSearchedKeywordHistory()
        
        adjustSearchBar()

        setupDelegatesAndDatasources()
        
        setupEmptyTableViewAlert()
        
    }
    
    private func getSearchedKeywordHistory() {
        searchKeywords = defaults.getHistoryList()
    }
    
    fileprivate func setupNavbarLogo() {
        let logoView = UIImageView(image: UIImage(named: "App-logo"))
        logoView.contentMode = .scaleToFill
        logoView.clipsToBounds = true
        self.navigationItem.titleView = logoView
    }
    
    fileprivate func setupBlackShadowView() {
        ////////////////////////////////////////////////
        //Setup shadow layer (view) and set constraits//
        ////////////////////////////////////////////////
        let leadingConstraint = blackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = blackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let topConstraint = blackView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let bottomConstraint = blackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -34)
        blackViewConstrains.append(contentsOf: [leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        self.view.addSubview(blackView)
        NSLayoutConstraint.activate(blackViewConstrains)
        blackView.isHidden = true
    }
    
    fileprivate func setupEmptyTableViewAlert() {
        /////////////////////////////////////////////////////////
        //Adjust table is empty alert (view) and set constraits//
        /////////////////////////////////////////////////////////
        resultTable.backgroundView = tableViewBackground
        tableViewBackground.translatesAutoresizingMaskIntoConstraints = false
        tableViewBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableViewBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        // Get searchbar height to equal top anchor with it
        let searchbarHeight: CGFloat = searchController.searchBar.bounds.size.height
        tableViewBackground.topAnchor.constraint(equalTo: self.view.topAnchor, constant: searchbarHeight).isActive = true
        tableViewBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -34).isActive = true
        tableViewBackground.isHidden = true
        
        hideKeyboardWhentapOnEmptyView()
    }
    
    fileprivate func setupDelegatesAndDatasources() {
        //////////////////////////////////////////////////////
        //Adjust tables & searchbar delegate and dataSources//
        //////////////////////////////////////////////////////
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        
        resultTable.delegate = self
        resultTable.dataSource = self
        searchController.searchBar.delegate = self
        
    }
    
    private func adjustSearchBar() {
        // Searchbar setup
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "ادخل النص"
        resultTable.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
                
        if searchQuery != "" {
            searchController.searchBar.text = searchQuery
        }
    }
    
    // MARK :- Add edge pan gesture to open menu via swiping left edge
    fileprivate func addEdgePanGestureToScreen() {
        let edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgeSwipe))
        edgeGesture.edges = .left
        self.view.addGestureRecognizer(edgeGesture)
    }
    
    @objc fileprivate func handleEdgeSwipe() {
        showMenu()
        menuIsShown = !menuIsShown
    }
    
    // MARK :- Add swipe gesture to can be close when swiping to left
    fileprivate func addGestureToSideMenu() {
        sideMenu.isUserInteractionEnabled = true
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeToLeft))
        swipeGesture.direction = .left
        sideMenu.addGestureRecognizer(swipeGesture)
    }
    
    @objc fileprivate func handleSwipeToLeft() {
        hideMenu()
        menuIsShown = !menuIsShown
    }
    
    // MARK :- Menu button pressed
    @IBAction func menuButtonPressed(_ sender: Any) {
        
        if menuIsShown {
            hideMenu()
        } else {
            showMenu()
        }
        menuIsShown = !menuIsShown
    }
    
    fileprivate func showMenu() {
        self.sideMenu.becomeFirstResponder()
        
        // If the keyboard is show hide it
        searchController.searchBar.endEditing(true)
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
    
    // MARK :- Set verse number and surah number before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toDetailView" {
            let destinationViewController = segue.destination as? DetailController
            
            if self.searchObject.ayahNumber != 0 && self.searchObject.surahNumber != 0 {
                destinationViewController?.searchObject = self.searchObject
            }
        }
    }
    
}




// MARK :- Delegate and manage data of table view here
extension MainController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text!
        
        if searchText == "" || searchText.count <= 0 {
            // Change color to red because no result
            self.searchResultLabel.textColor = UIColor.black
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
                self.searchResultLabel.textColor = self.customGreen
                let numberAsString = String(self.resultlist.count)
                self.searchResultLabel.text = "تم العثور على \(numberAsString.replaceEnglishDigitsWithArabic) أية"
            }
            
            // Table populated now and lets to animate cells
            animations.animateTableCells(table: self.resultTable)
            
            self.spinnerActivity?.hide(animated: true, afterDelay: 1.0)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var returnVal = 0
        
        // We have two table thats why firt we have to choose which tabel working here
        if tableView == self.sideMenuTableView {
            returnVal = DataSource.shared.textArray.count
        } else if tableView == self.resultTable {
            
            if resultlist.count == 0 {
                tableView.separatorStyle = .none
                tableView.isScrollEnabled = false
                tableViewBackground.isHidden = false
            } else {
                tableView.separatorStyle = .singleLine
                tableView.isScrollEnabled = true
                tableViewBackground.isHidden = true
            }
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
            let resultLine = resultlist[indexPath.row].ayahText
            resultCell?.VerseTextLabel.chageColorOfText(lineOfText: resultLine, text: searchQuery, color: UIColor.red)
            resultCell?.surahNameLabel.text = "\(resultlist[indexPath.row].surahNumber)".replaceEnglishDigitsWithArabic
            resultCell?.numberOfVerseLabel.text = "\(resultlist[indexPath.row].ayahNumber)".replaceEnglishDigitsWithArabic
            return resultCell!
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.resultTable {
            data.findByWordWithIndex(query: searchQuery, selectedIndex: indexPath.row) { (searchObj) in
                self.searchObject = searchObj
            }
            // Perform seguae
            self.performSegue(withIdentifier: "toDetailView", sender: self)
            
        } else if tableView == self.sideMenuTableView {
            let index = indexPath.item
            switch index {
            case 0:
                performSegue(withIdentifier: "toQuranComplete", sender: self)
                hideMenu()
                menuIsShown = !menuIsShown
                break
            case 1:
                performSegue(withIdentifier: "toFeedbackPage", sender: self)
                hideMenu()
                menuIsShown = !menuIsShown
                break
            case 2:
                performSegue(withIdentifier: "toAboutPage", sender: self)
                hideMenu()
                menuIsShown = !menuIsShown
                break
            default:
                print("Table cannot include more than 4 rows!")
            }
        }
    }
    
    // Hide keyboard methods
    // 1- When the scroll starts
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchController.searchBar.endEditing(true)
    }
    
    // When the search button pressed
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchQuery != "" && searchQuery.count >= 3 {
            if !searchKeywords.contains(searchQuery) {
                searchKeywords.append(searchQuery)
                defaults.saveHistoryList(list: searchKeywords)
            }
        }
        self.searchController.searchBar.endEditing(true)
    }
    
    // Hide keyboard when cancel button pressed
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.searchBar.endEditing(true)
        self.view.endEditing(true)
    }
    
    func hideKeyboardWhentapOnEmptyView() {
        tableEmptyView.isUserInteractionEnabled = true
        tableEmptyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
    }
    
    @objc private func handleTap() {
        self.searchController.searchBar.endEditing(true)
        self.view.endEditing(true)
    }
}
