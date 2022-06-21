//
//  RecommendationCell.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 25.01.22.
//

import UIKit

class RecommendationCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

  
    func setup (text: String){
        nameLabel.text = text
    }

}
