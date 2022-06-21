//
//  NetworkSevrice.swift
//  InfoDogs
//
//  Created by Никита Ерофеев on 4.02.22.
//

import Foundation


final class NetworkService {
    
    private  let host = "https://api.thedogapi.com/v1/breeds?attach_breed=0"
   
    
    func getBreeds(completion: @escaping ([Breeds])->Void) {
    
        guard let url = URL(string: host) else {return}
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "GET"

        
        URLSession.shared.dataTask(with: reqest) { responseData, response, error in
            if let error = error {
              
                print(error.localizedDescription)
                
            } else if let data = responseData {
                
                let breeds = try? JSONDecoder().decode([Breeds].self, from: data)
                DispatchQueue.main.async {
                    completion(breeds ?? [])
             
                }
                
            }
            
        }.resume()
        
        
    }
    
    
    
    
}
