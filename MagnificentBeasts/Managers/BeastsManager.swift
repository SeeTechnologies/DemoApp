//
//  BeastsManager.swift
//  MagnificentBeasts
//
//  Created by LS on 2018-05-02.
//  Copyright © 2018 SeeTechnologies Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BeastsManager
{
    private static let beastEntityName = "MyBeast"
    
    static func createBeast(name: String, species: String, profile: String? = nil, ownerId: Int64 = 0, aquatic: Bool = false) throws
    {
        //TODO: if ownerId != 0 create a MyBeast instance, otherwise create a UnownedBeast instance
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let beastEntityDescription = NSEntityDescription.entity(forEntityName: beastEntityName, in: managedObjectContext)!
        let beast = MyBeast(entity: beastEntityDescription, insertInto: managedObjectContext)
        
        beast.name = name
        beast.species = species
        beast.profile = profile
        beast.ownerId = ownerId
        beast.aquatic = aquatic
        
        do {
            try managedObjectContext.save()
        } catch let error as Error {
            throw error
        }
    }
    
    static func fetchBeasts(ownerId: Int64) -> [MyBeast]
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<MyBeast>(entityName: beastEntityName)
        
        do {
            return try managedObjectContext.fetch(fetchRequest)
            
        } catch let error as Error {
            print("Fetch beasts error - \(error.localizedDescription)")
            return [MyBeast]()
        }
    }
}
