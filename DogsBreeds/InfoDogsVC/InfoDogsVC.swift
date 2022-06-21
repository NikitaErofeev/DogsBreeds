
import UIKit

class InfoDogsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource {
    
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    @IBOutlet private weak var textTableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!{
        didSet{
                if isFavorite {
                    nameLabel.text = breed.name
                } else {
                    nameLabel.text = nameFromNetwork?.name}
        }
    }
    
    var isFavorite: Bool = false
    var breed = FavoriteBreed ()
    var dogImage: UIImage?{
        didSet{
            collectionView.reloadData()
        }
    }
    var nameFromNetwork: Breeds?
    @IBOutlet private weak var favoriteButtonOutlet: UIBarButtonItem!
    @IBAction private func favoriteActionButton(_ sender: UIBarButtonItem) {
        favoriteButtonOutlet.isSelected = !favoriteButtonOutlet.isSelected
        if favoriteButtonOutlet.isSelected {
            favoriteButtonOutlet.image = UIImage(systemName: "star.fill")
            if !isFavorite{
                let newDog = FavoriteBreed(context: CoreDataService.managedObjectContext)
                newDog.temperament = nameFromNetwork?.temperament
                newDog.weight = nameFromNetwork?.weight?.metric
                newDog.lifeSpan = nameFromNetwork?.lifeSpan
                newDog.rare = nameFromNetwork?.height?.metric
                newDog.name = nameFromNetwork?.name
                newDog.origin = nameFromNetwork?.origin
                newDog.image = nameFromNetwork?.image?.url
                CoreDataService.saveContext()
            }
        } else {
            CoreDataService.persistentContainer.viewContext.delete(breed)
            CoreDataService.saveContext()
            favoriteButtonOutlet.isSelected = false
            favoriteButtonOutlet.image = UIImage(systemName: "star")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell
        cell?.dogImage.image = dogImage
        cell?.layer.cornerRadius = 30
        return cell ?? UICollectionViewCell()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 30
        collectionView.layer.cornerRadius = 30
        collectionView.delegate = self
        collectionView.dataSource = self
        textTableView.dataSource = self
        activity.isHidden = false
        activity.startAnimating()
        if isFavorite {
            installImage(url: breed.image)
            favoriteButtonOutlet.isSelected = true
        } else {
            installImage(url: nameFromNetwork?.image?.url)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parametrArray.count
    }
  
    var parametrArray = ["Origin", "Rare", "Life span", "Weight", "Temperament"]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TableVCell.self)", for: indexPath) as? TableVCell
        cell?.parametrLabel.text = parametrArray[indexPath.row]
        if isFavorite{
             let dogFromCoreData = breed
            switch parametrArray[indexPath.row] {
            case parametrArray[0]: cell?.descriptionLabel.text = dogFromCoreData.origin
            case parametrArray[1]: cell?.descriptionLabel.text = dogFromCoreData.weight
            case parametrArray[2]: cell?.descriptionLabel.text = dogFromCoreData.lifeSpan
            case parametrArray[3]: cell?.descriptionLabel.text = dogFromCoreData.weight
            case parametrArray[4]: cell?.descriptionLabel.text = dogFromCoreData.temperament
            default: print("Error InfoDogsVC CellForRowAt")
            }
        } else {
            guard let dog = nameFromNetwork else {return UITableViewCell()}
            switch parametrArray[indexPath.row] {
            case parametrArray[0]: cell?.descriptionLabel.text = dog.origin
            case parametrArray[1]: cell?.descriptionLabel.text = dog.height?.metric
            case parametrArray[2]: cell?.descriptionLabel.text = dog.lifeSpan
            case parametrArray[3]: cell?.descriptionLabel.text = dog.weight?.metric
            case parametrArray[4]: cell?.descriptionLabel.text = dog.temperament
            default: print("Error InfoDogsVC CellForRowAt")
            }
        }
        return cell ?? UITableViewCell()
    }

     func installImage(url: String?) {
        let queue = DispatchQueue(label: "DownloadImage", qos: .background)
        queue.async { [weak self] in
            if let unwrNetwork = url{

                    if let imageURL = URL(string: unwrNetwork),
                       let imageData = try? Data(contentsOf: imageURL),
                       let image = UIImage(data: imageData){
                        DispatchQueue.main.async { [weak self] in
                            self?.activity.isHidden = true
                            self?.activity.stopAnimating()
                            self?.dogImage = image
                        }
                        
                    }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.popToRootViewController(animated: false)
    }
}
