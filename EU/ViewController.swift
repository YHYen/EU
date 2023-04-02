//
//  ViewController.swift
//  EU
//
//  Created by 顏逸修 on 2023/4/2.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var members = ["Austria",
                  "Belgium",
                  "Bulgaria",
                  "Croatia",
                  "Cyprus",
                  "Czechia",
                  "Denmark",
                  "Estonia",
                  "Finland",
                  "France",
                  "Germany",
                  "Greece",
                  "Hungary",
                  "Ireland",
                  "Italy",
                  "Latvia",
                  "Lithuania",
                  "Luxembourg",
                  "Malta",
                  "Netherlands",
                  "Poland",
                  "Portugal",
                  "Romania",
                  "Slovakia",
                  "Slovenia",
                  "Spain",
                  "Sweden",
                  "United Kingdom"
]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            // determine the destination of the data transfer
            let destination = segue.destination as! CountryDetailTableViewController
            
            // get the indexPath from tableView which row you click
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            
            // set the data of destination from indexPath.row
            destination.countryName = members[selectedIndexPath.row]
        } else if segue.identifier == "AddDetail" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // cancel the selection state of the cell
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        // some action when the saveButton Pressed
        // get the data from the previous view controller
        let source = segue.source as! CountryDetailTableViewController
        
        // check to see if the data's indexPath is nil or not (if is nil, it means that it is a new data)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // if indexPath is not nil, change the data from the existed indexPath
            members[selectedIndexPath.row] = source.countryName
            
            // automatic reload the tableView
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            // if is nil, append new data from source to members array
            // get newIndexPath
            let newIndexPath = IndexPath(row: members.count, section: 0)
            
            // append data to members array
            members.append(source.countryName)
            
            // insert the row into the new IndexPath at the bottom of the tableView
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            
            // scroll the tableView to new data
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = members[indexPath.row]
        return cell
    }
    
    
}

