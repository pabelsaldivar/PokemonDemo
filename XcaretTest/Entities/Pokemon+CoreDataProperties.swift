//
//  Pokemon+CoreDataProperties.swift
//  
//
//  Created by Jonathan Pabel Saldivar Mendoza on 30/04/21.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int16
    @NSManaged public var url: String?
    @NSManaged public var imageName: String?

}
