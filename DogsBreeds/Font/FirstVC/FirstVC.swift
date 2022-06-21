//
//  FirstVC.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 13.02.22.
//

import UIKit

class FirstVC: UITabBarController, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var textTable: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    var arrayUIImage: [UIImage] = []{
        didSet{
            arrayBreeds.forEach { breed in
                let newURLStr = breed.image?.url
                installImage(url: newURLStr)
            }
        }
    }
    var timer = Timer()
    var counter = 1
    var arrayBreeds: [Breeds] = [] {
        didSet{
            reloadInputViews()
            
        }
    }
    
    let networkService = NetworkService()
    @objc func changeImage() {
        
        if counter < arrayUIImage.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
            
        } else  {
            counter = 0
            let index = IndexPath.init(item: counter , section: 0)
            
            self.collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            
            counter = 1
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
        networkService.getBreeds { [weak self] breeds in
            self?.arrayBreeds = breeds
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(AllDescription.self)", for: indexPath) as? AllDescription
        cell?.descriptionLabel.text = "SOME TEXT"
        
        return cell ?? UITableViewCell()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayUIImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AnimationVCell.self)", for: indexPath) as? AnimationVCell
        
        cell?.imageView.image = arrayUIImage[indexPath.row]
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func installImage(url: String?) {
        let queue = DispatchQueue(label: "DownloadImage", qos: .background)
        queue.async { [weak self] in
            if let unwrNetwork = url{

                    if let imageURL = URL(string: unwrNetwork),
                       let imageData = try? Data(contentsOf: imageURL),
                       let image = UIImage(data: imageData){
                        DispatchQueue.main.async { [weak self] in
                            self?.arrayUIImage.append(image)
                        }
                    }
            }
        }
    }
    
}
