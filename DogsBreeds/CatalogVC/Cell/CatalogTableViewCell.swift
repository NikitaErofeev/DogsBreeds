//
//  CatalogTableViewCell.swift
//  DogsBreeds
//
//  Created by Никита Ерофеев on 27.02.22.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {

 
    @IBOutlet weak var nameLabel: UILabel!
    
    func setup(name: Breeds) {
        nameLabel.text = name.name
    }
    
}
