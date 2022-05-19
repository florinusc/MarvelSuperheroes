//
//  CoreDataLocalDataManager.swift
//  MarvelSuperheroes
//
//  Created by Florin Uscatu on 19.05.2022.
//

import UIKit
import CoreData

class CoreDataLocalDataManager: LocalDataManager {
    
    private let entityName = "SuperheroEntity"
    
    private var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    private var managedContext: NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveSquadMember(hero: Superhero) throws {
        
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else { throw CustomError.general }
        
        let superhero = NSManagedObject(entity: entity, insertInto: managedContext)
        
        superhero.setValue(hero.id, forKeyPath: "id")
        superhero.setValue(hero.name, forKeyPath: "name")
        superhero.setValue(hero.description, forKeyPath: "heroDescription")
        superhero.setValue(hero.imageURL, forKeyPath: "imageURL")
        
        try managedContext.save()
        
    }
    
    func getSquadMembers() throws -> [Superhero] {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        let managedObjects = try managedContext.fetch(fetchRequest)
        
        return managedObjects.compactMap { managedObject -> Superhero? in
            guard
                let id = managedObject.value(forKeyPath: "id") as? String,
                let name = managedObject.value(forKeyPath: "name") as? String,
                let description = managedObject.value(forKeyPath: "heroDescription") as? String,
                let imageURL = managedObject.value(forKeyPath: "imageURL") as? String
            else {
                return nil
            }
            return Superhero(id: id, name: name, description: description, imageURL: imageURL)
        }
        
    }
    
    func removeSquadMember(hero: Superhero) throws {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        let managedObjects = try managedContext.fetch(fetchRequest)
        
        guard let managedObject = managedObjects.first(where: { managedObject in
            guard let id = managedObject.value(forKey: "id") as? String else { return false }
            return id == hero.id
        }) else {
            throw CustomError.general
        }
        
        managedContext.delete(managedObject)
        
        try managedContext.save()
        
    }
    
}
