//
//  FavoriteBreed+CoreDataProperties.swift
//  DogsBreeds
//
//  Created by Никита Ерофеев on 14.02.22.
//
//

import Foundation
import CoreData


extension FavoriteBreed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteBreed> {
        return NSFetchRequest<FavoriteBreed>(entityName: "FavoriteBreed")
    }

    @NSManaged public var name: String?
    @NSManaged public var rare: String?
    @NSManaged public var lifeSpan: String?
    @NSManaged public var weight: String?
    @NSManaged public var temperament: String?
    @NSManaged public var image: String?
    @NSManaged public var origin: String?

}

extension FavoriteBreed : Identifiable {

}
