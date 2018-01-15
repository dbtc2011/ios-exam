//
//  PersonsListTableViewController.swift
//  PersonsList
//
//  Created by Mark Louie Angeles on 16/01/2018.
//  Copyright © 2018 Mark Louie Angeles. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
/* Wait for api if there is avaiable, for now use sample json

*/
class PersonsListTableViewController: UITableViewController {
    
    private var tableData :  [PersonObject] = []

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getPersonsList()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Functions
    func setupUI() {
        tableView.estimatedRowHeight = 55.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // Download json for temporary data
    func getPersonsList() {
        
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
                                    self.tableData.removeAll()
                                    var id = 1
                                    for content in arrayContent {
                                        let dictionaryContent = content as! [String : String]
                                        let newPerson = PersonObject(info: dictionaryContent)
                                        _ = DatabaseManager.sharedInstance.createPerson(person: newPerson, id: id)
                                        self.tableData.append(newPerson)
                                        id = id + 1
                                    }
                                    CoreDataStack.saveContext()
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                        } catch let error{
                            print(error.localizedDescription)
                            
                        }
                    }
                }
                task.resume()
            }
        }else {
            print("Get data from DB")
            self.tableData.removeAll()
            for content in persons {
                let newPerson = PersonObject(core: content)
                self.tableData.append(newPerson)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personListCell", for: indexPath) as! PersonTableViewCell
        cell.configureCell(person: tableData[indexPath.row])
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.white
        }else {
            cell.contentView.backgroundColor = UIColor(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let person = tableData[indexPath.row]
        performSegue(withIdentifier: "personDetails", sender: person)
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? PersonDetailViewController {
            if let person = sender as? PersonObject {
                controller.person = person
            }
        }
    }
 

}
