//
//  TableViewCell.swift
//  DogsBreeds
//
//  Created by Никита Ерофеев on 25.02.22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    func installLabel(name: String){
        nameLabel.text = name
    }

}
