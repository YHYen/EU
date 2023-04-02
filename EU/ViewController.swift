//
//  ViewController.swift
//  EU
//
//  Created by 顏逸修 on 2023/4/2.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var nations: [Nation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            // determine the destination of the data transfer
            let destination = segue.destination as! CountryDetailTableViewController
            
            // get the indexPath from tableView which row you click
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            
            // set the data of destination from indexPath.row
            destination.nation = nations[selectedIndexPath.row]
        } else if segue.identifier == "AddDetail" {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // cancel the selection state of the cell
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    
    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("nations").appendingPathExtension("json")
        
        guard let data = try? Data(contentsOf: documentURL) else {return}
        let jsonDecoder = JSONDecoder()
        
        do {
            nations = try jsonDecoder.decode(Array<Nation>.self, from: data)
            tableView.reloadData()
        } catch {
            print("😡 ERROR: Could not load data! \(error.localizedDescription).")
        }
    }
    
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("nations").appendingPathExtension("json")
        
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(nations)
        
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("😡 ERROR: Could not save data! \(error.localizedDescription).")
        }
    }
    
    
    @IBAction func unwindFromDetail(segue: UIStoryboardSegue) {
        // some action when the saveButton Pressed
        // get the data from the previous view controller
        let source = segue.source as! CountryDetailTableViewController
        
        // check to see if the data's indexPath is nil or not (if is nil, it means that it is a new data)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            // if indexPath is not nil, change the data from the existed indexPath
            nations[selectedIndexPath.row] = source.nation
            
            // automatic reload the tableView
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            // if is nil, append new data from source to members array
            // get newIndexPath
            let newIndexPath = IndexPath(row: nations.count, section: 0)
            
            // append data to members array
            nations.append(source.nation)
            
            // insert the row into the new IndexPath at the bottom of the tableView
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            
            // scroll the tableView to new data
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
        
        saveData()
    }


    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = nations[indexPath.row].country
        cell.detailTextLabel?.text = "Captial: \(nations[indexPath.row].capital)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            nations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = nations[sourceIndexPath.row]
        nations.remove(at: sourceIndexPath.row)
        nations.insert(itemToMove, at: destinationIndexPath.row)
        saveData()
    }
}

