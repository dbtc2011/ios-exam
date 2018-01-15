//
//  PersonTableViewCell.swift
//  PersonsList
//
//  Created by Mark Louie Angeles on 16/01/2018.
//  Copyright © 2018 Mark Louie Angeles. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
   

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell(person: PersonObject) {
        
        name.text = person.firstName + " " + person.lastName
        
        
    
    }

}
