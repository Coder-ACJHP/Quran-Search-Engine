//
//  QuranCompleteController.swift
//  Quran Search Engine
//
//  Created by akademobi5 on 17.07.2018.
//  Copyright © 2018 Coder ACJHP. All rights reserved.
//

import UIKit

class QuranCompleteController: UIViewController {

    var selectedRowNumber = 0
    var data = DataSource.shared
    var service = ServiceData.shared
    @IBOutlet weak var searchbar: UITableView!
    @IBOutlet weak var indexTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //////////////////////////////////////////////////////
        //Adjust tables & searchbar delegate and dataSources//
        //////////////////////////////////////////////////////
        indexTable.delegate = self
        indexTable.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSurah" {
            let destinationVC = segue.destination as! SurahCompletlyController
            destinationVC.volatileNumber = selectedRowNumber
            
        }
    }
}

extension QuranCompleteController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.quranSurahIndex.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: "surahCell", for: indexPath) as! SearchCell
        let number = String(indexPath.row + 1)
        customCell.surahNameLabel.text = "السورة" + " " + data.quranSurahIndex[number]!
        
        return customCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRowNumber = indexPath.row + 1
        self.performSegue(withIdentifier: "toSurah", sender: self)
    }
}










