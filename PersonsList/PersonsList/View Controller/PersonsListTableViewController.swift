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
import PKHUD
/* Wait for api if there is avaiable, for now use sample json

*/
class PersonsListTableViewController: UITableViewController {
    
    private var tableData :  [PersonObject] = []

    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getPersonsList()
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
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        PKHUD.sharedHUD.show()
        
        PersonListLoader.getPersonsList { (list) in
            self.tableData = list
            DispatchQueue.main.async {
                PKHUD.sharedHUD.hide(afterDelay: 1.0) { success in
                    // Completion Handler
                    self.tableView.reloadData()
                }
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

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PersonDetailViewController {
            if let person = sender as? PersonObject {
                controller.person = person
            }
        }
    }
 
}
