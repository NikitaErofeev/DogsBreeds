//
//  FavoriteBreed+CoreDataClass.swift
//  DogsBreeds
//
//  Created by Никита Ерофеев on 14.02.22.
//
//

import Foundation
import CoreData

@objc(FavoriteBreed)
public class FavoriteBreed: NSManagedObject {

    convenience init?(moc:NSManagedObjectContext){
        if let entity = NSEntityDescription.entity(forEntityName: "\(FavoriteBreed.self)", in: moc) {
            self.init(entity: entity, insertInto: moc)
        } else {
            return nil
        }
    }
}
