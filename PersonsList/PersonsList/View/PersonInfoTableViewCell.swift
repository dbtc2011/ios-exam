//
//  PersonInfoTableViewCell.swift
//  PersonsList
//
//  Created by Mark Louie Angeles on 16/01/2018.
//  Copyright © 2018 Mark Louie Angeles. All rights reserved.
//

import UIKit

class PersonInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var value: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureCell(person: PersonObject, index: Int) {
        
        switch index {
        case 0:
            
            title.text = "First name"
            value.text = person.firstName
            break
            
        case 1:
            
            title.text = "Last name"
            value.text = person.lastName
            break
        case 2:
            
            title.text = "Birthday"
            value.text = person.birthday
            break
        case 3:
            
            title.text = "Age"
            value.text = "\(person.age)"
            break
        case 4:
            
            title.text = "Email address"
            value.text = person.emailAddress
            break
        case 5:
            
            title.text = "Mobile number"
            value.text = person.mobileNumber
            break
        case 6:
            
            title.text = "Address"
            value.text = person.address
            break
        case 7:
            
            title.text = "Contact person"
            value.text = person.contactPerson
            break
        case 8:
            
            title.text = "Contact person's phone number"
            value.text = person.contactPersonMobileNumber
            break
        default:
            
            break
        }
    
    }

}
