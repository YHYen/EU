//
//  ListTableViewCell.swift
//  EU
//
//  Created by 顏逸修 on 2023/4/3.
//

import UIKit


protocol ListTableViewCellDelegate: AnyObject {
    func euroButtonToggle(sender: ListTableViewCell)
}


class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var euroButton: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var captialLabel: UILabel!
    
    
    weak var delegate: ListTableViewCellDelegate?
    
    
    var nation: Nation! {
        didSet {
            countryLabel.text = nation.country
            captialLabel.text = nation.capital
            euroButton.isSelected = nation.usesEuro
        }
    }
    
    
    @IBAction func euroTapped(_ sender: UIButton) {
        delegate?.euroButtonToggle(sender: self)
    }
}
