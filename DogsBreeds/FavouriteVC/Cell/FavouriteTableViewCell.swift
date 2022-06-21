//
//  FavouriteTableViewCell.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 22.01.22.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var labelBreed: UILabel!
    

    func setup (nameDog: FavoriteBreed){
        labelBreed.text = nameDog.name
    }
    
    
}
