//
//  TabBarVC.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 12.02.22.
//

import UIKit

class TabBarVC: UITabBarController {
    
    
    var arrayBreeds: [Breeds] = [] {
        didSet{
            reloadInputViews()
            
        }
    }
    
    let networkService = NetworkService()
    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.getBreeds { [weak self] breeds in
            self?.arrayBreeds = breeds
          
        }
       
    }
    
  
   

}
