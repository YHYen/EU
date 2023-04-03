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
    @IBOutlet weak var euroSwitch: UISwitch!
    
    var nation: Nation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if nation == nil {
            nation = Nation(country: "", capital: "", usesEuro: false)
        }
        
        
        countryTextField.text = nation.country
        capitalTextField.text = nation.capital
        euroSwitch.isOn = nation.usesEuro
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        nation = Nation(country: countryTextField.text!, capital: capitalTextField.text!, usesEuro: euroSwitch.isOn)
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
