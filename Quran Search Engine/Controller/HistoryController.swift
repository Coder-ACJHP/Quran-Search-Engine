//
//  HistoryController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 25.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class HistoryController: UIViewController {

    var selectedCellText = String()
    var historyList = [String]()
    let defaults = TempDatabase.shared
    let animations = Animations.shared
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet var emptyTableView: UIView!
    @IBOutlet weak var emptyTableViewBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch saved history
        historyList = defaults.getHistoryList()
        
        // Add outer view to tableView background view
        dataTable.backgroundView = emptyTableView
        
        // Arange empty view constraints
        emptyTableView.translatesAutoresizingMaskIntoConstraints = false
        emptyTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        emptyTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        // Get searchbar height to equal top anchor with it
        let navbarHeight: CGFloat = (self.navigationController?.navigationBar.bounds.size.height)!
        emptyTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: navbarHeight).isActive = true
        emptyTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // Hide it !
        emptyTableView.isHidden = true
        
        // Remove spaces that added for header and footer in table view.
        dataTable.contentInset = UIEdgeInsetsMake(-30, 0, -20, 0);
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Mark :- Animate table view cells like spring.
        animations.animateTableCells(table: self.dataTable)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMainView" {
            let destinationController = segue.destination as! MainController
            destinationController.searchQuery = selectedCellText
        }
    }
    
}


extension HistoryController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK :- UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if historyList.count == 0 {
            // Now show empty view and adjust table properties.
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
            emptyTableView.isHidden = false
        } else {
            // And hide it again.
            tableView.separatorStyle = .singleLine
            tableView.isScrollEnabled = true
            emptyTableView.isHidden = true
        }
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        cell.textLabel?.text = historyList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! HistoryCell
        selectedCellText = (currentCell.textLabel?.text)!
        self.performSegue(withIdentifier: "toMainView", sender: nil)
    }
    // Erase selected cell text
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedCellText = ""
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            historyList.remove(at: indexPath.row)
            defaults.saveHistoryList(list: historyList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
    
}
