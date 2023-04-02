//
//  CountryDetailTableViewController.swift
//  EU
//
//  Created by 顏逸修 on 2023/4/2.
//

import UIKit

class CountryDetailTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var capitalTextField: UITextField!
    
    var countryName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if countryName == nil {
            countryName = ""
        }
        
        countryTextField.text = countryName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        countryName = countryTextField.text
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
