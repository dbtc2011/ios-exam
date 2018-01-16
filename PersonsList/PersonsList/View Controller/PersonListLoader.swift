//
//  PersonListLoader.swift
//  PersonsList
//
//  Created by Mark Louie Angeles on 16/01/2018.
//  Copyright © 2018 Mark Louie Angeles. All rights reserved.
//

import Foundation
import CoreData

class PersonListLoader {
    class func getPersonsList(completion: @escaping (_ persons: [PersonObject])-> Void) {
        var returnPerson: [PersonObject] = []
        let persons = DatabaseManager.sharedInstance.fetchPersons()
        if persons.count == 0 {
            print("Download json file")
            let url = "http://pencoop.net/public/personslist.json"
            if let requestUrl = URL(string:url) {
                
                let request = URLRequest(url:requestUrl)
                let task = URLSession.shared.dataTask(with: request) {
                    (data, response, error) in
                    if error == nil,let usableData = data {
                        do {
                            let json =  try JSONSerialization.jsonObject(with: usableData, options: .allowFragments)
                            if let resultDictionary = json as? [String : Any] {
                                if let arrayContent = resultDictionary["result"] as? NSArray {
                                    var id = 1
                                    for content in arrayContent {
                                        let dictionaryContent = content as! [String : String]
                                        let newPerson = PersonObject(info: dictionaryContent)
                                        _ = DatabaseManager.sharedInstance.createPerson(person: newPerson, id: id)
                                        returnPerson.append(newPerson)
                                        id = id + 1
                                    }
                                    CoreDataStack.saveContext()
                                    completion(returnPerson)
                                }
                            }
                        } catch let error{
                            completion(returnPerson)
                            print(error.localizedDescription)
                            
                        }
                    }
                }
                task.resume()
            }else {
                completion(returnPerson)
            }
        }else {
            print("Get data from DB")
            for content in persons {
                let newPerson = PersonObject(core: content)
                returnPerson.append(newPerson)
            }
            completion(returnPerson)
            
        }
    }
    
}
