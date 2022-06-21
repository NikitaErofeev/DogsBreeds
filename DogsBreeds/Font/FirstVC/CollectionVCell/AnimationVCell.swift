//
//  AnimationVCell.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 13.02.22.
//

import UIKit

class AnimationVCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!{
        didSet{
            imageView.layer.cornerRadius = 30
        }
    }
}
