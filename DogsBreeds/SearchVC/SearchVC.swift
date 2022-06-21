

import UIKit

class SearchVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
 
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tabelView: UITableView!
    @IBOutlet private weak var backgroundView: UIView!
    
    var filteredArray: [String] = []
    let tabBarVC = TabBarVC()
    var arrayBreeds: [Breeds] = []
    var namesBreeds: [String] = []
    let tabBar = UITabBar()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        cell?.installLabel(name: filteredArray[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.becomeFirstResponder()
        tabelView.deselectRow(at: indexPath, animated: true)
        searchBar.text = filteredArray[indexPath.row]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tabelView.dataSource = self
        tabelView.delegate = self
        backgroundView.layer.cornerRadius = 30
        arrayBreeds = tabBarVC.arrayBreeds
        arrayBreeds.forEach { breed in
            namesBreeds.append(breed.name)
        }
        filteredArray = namesBreeds
        tabelView.isHidden = true
    }
  
    @IBAction func searchButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "InfoDogsVC") as? InfoDogsVC else {return}
        
        for breed in arrayBreeds {
            
            if let first =  namesBreeds.first(where: {$0.contains(searchBar.text!)}) {
                searchBar.text = first
            }

            if breed.name == searchBar.text{
                let request = FavoriteBreed.fetchRequest()
                request.predicate = NSPredicate(format: "name == %@", breed.name)
                request.fetchLimit = 1
                let breeds = try? CoreDataService.managedObjectContext.fetch(request)
                if  let breed = breeds?.first {
                    nextVC.breed = breed
                    nextVC.isFavorite = true
                }
                nextVC.nameFromNetwork = breed
                navigationController?.pushViewController(nextVC, animated: true)
                searchBar.text = nil
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArray = searchText.isEmpty ? namesBreeds : namesBreeds.filter({ (item: String) -> Bool in
            tabelView.isHidden = false
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        })
        tabelView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tabelView.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

