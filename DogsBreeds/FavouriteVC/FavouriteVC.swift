
import UIKit
import CoreData

class FavouriteVC: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var fetchedResultController: NSFetchedResultsController<FavoriteBreed>!
    let breed = FavoriteBreed ()
     var breeds = [FavoriteBreed](){
        didSet{
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as? FavouriteTableViewCell
        cell?.setup(nameDog: breeds[indexPath.row])

        return cell ?? UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "\(InfoDogsVC.self)") as? InfoDogsVC else {return}
        nextVC.isFavorite = true
        nextVC.breed = breeds[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(nextVC, animated: true)

    }
      
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            
            let breed = self.breeds[indexPath.row]
            CoreDataService.persistentContainer.viewContext.delete(breed)
            CoreDataService.saveContext()
            self.loadBreed()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupFetchedResultController()
        loadBreed()
    }
  
    private func setupFetchedResultController() {
        let request = FavoriteBreed.fetchRequest()
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescription]
        fetchedResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataService.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
    }
    
    private func loadBreed () {
        try? fetchedResultController.performFetch()
        if let result = fetchedResultController.fetchedObjects {
            
            breeds = result
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        loadBreed()
    }

}
