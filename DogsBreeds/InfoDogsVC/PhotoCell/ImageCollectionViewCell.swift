//
//  ImageCollectionViewCell.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 22.01.22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    
  
    @IBOutlet weak var dogImage: UIImageView!{
        didSet{
            dogImage.layer.cornerRadius = 30
        }
    }
    

    
}
