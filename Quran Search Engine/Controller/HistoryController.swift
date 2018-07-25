//
//  HistoryController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 25.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class HistoryController: UIViewController {

    var historyList = [String]()
    let defaults = TempDatabase.shared
    @IBOutlet weak var dataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch saved history
        historyList = defaults.getHistoryList()
    }

    
}

extension HistoryController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
