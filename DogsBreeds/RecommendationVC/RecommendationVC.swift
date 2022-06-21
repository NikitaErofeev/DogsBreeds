//
//  RecommendationVC.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 25.01.22.
//

import UIKit

class RecommendationVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let dicRecomendation = ["Советы по питанию": "https://www.purina.ru/dogs/health-and-nutrition/daily-feeding-guide/feeding-your-adult-dog", "Как правильно ухаживать за щенком": "https://www.purina.ru/dogs/key-life-stages/puppies", "Признаки беременности у собак": "https://www.purina.ru/dogs/key-life-stages/pregnancy/spotting-the-signs-of-pregnancy", "Вязка собак": "https://www.purina.ru/dogs/getting-a-new-dog/welcoming-your-dog/vjazka-sobak", "Что делать, если щенок кусается": "https://www.purina.ru/dogs/getting-a-new-dog/guide-for-new-dog-owners/shchenok-kusaetsya"]
    var tempArray: [String] = []


    @IBOutlet weak var recommendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendTableView.dataSource = self
        recommendTableView.delegate = self
        appendArrayKeys(dic: dicRecomendation)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dicRec = dicRecomendation[tempArray[indexPath.row]],  let urlComp = URLComponents (string: dicRec), let url = urlComp.url {
            UIApplication.shared.open (url)
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicRecomendation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendationCell", for: indexPath) as? RecommendationCell
        
        cell?.setup(text: tempArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func appendArrayKeys(dic: [String: String]) {
        for keys in dic.keys {
            tempArray.append(keys)
            
        }
        
        
    }

}
