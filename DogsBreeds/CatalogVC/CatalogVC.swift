
import UIKit

class CatalogVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var catalogTableView: UITableView!
    
    var tempDogImage: UIImage?
    var arrayBreeds: [Breeds] = []
    
    let tabBarVC = TabBarVC()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filtredArray: [Breeds] = []
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredArray.count
        }
        return arrayBreeds.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogTableViewCell", for: indexPath) as? CatalogTableViewCell
        var dog: Breeds
        if isFiltering {
            dog = filtredArray[indexPath.row]
        } else {
            dog = arrayBreeds[indexPath.row]
        }
        cell?.setup(name: dog)
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "InfoDogsVC") as? InfoDogsVC else {return}
        
        let dog: Breeds
        if isFiltering {
            dog = filtredArray[indexPath.row]
        } else {
            dog = arrayBreeds[indexPath.row]
        }
        
        let request = FavoriteBreed.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", dog.name)
        request.fetchLimit = 1
        let breeds = try? CoreDataService.managedObjectContext.fetch(request)
        if  let breed = breeds?.first {
            nextVC.breed = breed
            nextVC.isFavorite = true
        }
        
        nextVC.nameFromNetwork = dog
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catalogTableView.delegate = self
        catalogTableView.dataSource = self
        arrayBreeds = tabBarVC.arrayBreeds
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
  
}


extension CatalogVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchController.searchBar.text!)
    }
    
    func filteredContentForSearchText (_ searchText: String) {
        filtredArray = arrayBreeds.filter({ breed in
            return breed.name.lowercased().contains(searchText.lowercased())
        })
        catalogTableView.reloadData()
    }
    
}

