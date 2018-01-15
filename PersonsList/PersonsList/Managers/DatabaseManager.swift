//
//  DatabaseManager.swift
//  PersonsList
//
//  Created by Mark Louie Angeles on 16/01/2018.
//  Copyright © 2018 Mark Louie Angeles. All rights reserved.
//

import Foundation
import CoreData

public class DatabaseManager {
    
    static let sharedInstance = DatabaseManager()
    
    func createPerson(person : PersonObject, id : Int) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Person",
                                                in:CoreDataStack.managedObjectContext)
        let newPerson = Person(entity: entity!,
                        insertInto: CoreDataStack.managedObjectContext)
        newPerson.id = Int16(id)
        newPerson.firstName = person.firstName
        newPerson.lastName = person.lastName
        newPerson.birthday = person.birthday
        newPerson.age = Int16(person.age)
        newPerson.emailAddress = person.emailAddress
        newPerson.address = person.address
        newPerson.contactPerson = person.contactPerson
        newPerson.contactPersonsNumber = person.contactPersonMobileNumber
        newPerson.mobileNumber = person.mobileNumber

    }
    
    func fetchPersons() -> [Person] {
        let entityDescription =  NSEntityDescription.entity(forEntityName: "Person",
                                                            in:CoreDataStack.managedObjectContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        let sort = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            let fetchedResults = try CoreDataStack.managedObjectContext.fetch(fetchRequest) as! [Person]
            return fetchedResults
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            
        }
        return []
    }
}
