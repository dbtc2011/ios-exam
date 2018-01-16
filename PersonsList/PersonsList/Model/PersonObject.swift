//
//  PersonObject.swift
//  PersonsList
//
//  Created by Mark Louie Angeles on 16/01/2018.
//  Copyright © 2018 Mark Louie Angeles. All rights reserved.
//

import UIKit
import SwiftyJSON

/*
 
 First name
 Last name
 Birthday
 Age (derived from Birthday)
 Email address
 Mobile number
 Address
 Contact person
 Contact person's phone number
 */
class PersonObject: NSObject {
    
    var firstName : String = ""
    var lastName : String = ""
    var birthday : String = ""
    var age : Int = 0
    var emailAddress : String = ""
    var mobileNumber : String = ""
    var address : String = ""
    var contactPerson : String = ""
    var contactPersonMobileNumber : String = ""
    
    /*
     Uncomment if api is ready
    convenience init(info : JSON) {
        self.init()
        
        firstName = info["first_name"].string ?? ""
        firstName = info["last_name"].string ?? ""
        firstName = info["birthday"].string ?? ""
        firstName = info["email_address"].string ?? ""
        firstName = info["mobile_number"].string ?? ""
        firstName = info["address"].string ?? ""
        firstName = info["contact_person"].string ?? ""
        firstName = info["contact_person_mobile_number"].string ?? ""
    }
 */
    convenience init(info : [String : String]) {
        self.init()
        firstName = info["first_name"] ?? ""
        lastName = info["last_name"] ?? ""
        birthday = info["birthday"] ?? ""
        emailAddress = info["email_address"] ?? ""
        mobileNumber = info["mobile_number"] ?? ""
        address = info["address"] ?? ""
        contactPerson = info["contact_person"] ?? ""
        contactPersonMobileNumber = info["contact_person_mobile_number"] ?? ""
        setAge()
    }
    
    convenience init(core : Person) {
        self.init()
        firstName = core.firstName ?? ""
        lastName = core.lastName ?? ""
        birthday = core.birthday ?? ""
        emailAddress = core.emailAddress ?? ""
        mobileNumber = core.mobileNumber ?? ""
        address = core.address ?? ""
        contactPerson = core.contactPerson ?? ""
        contactPersonMobileNumber = core.contactPersonsNumber ?? ""
        age = Int(core.age)
        
    }

}


extension PersonObject {
    
    var fullName : String {
        return firstName + " " + lastName
    }
    
    func setAge() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let birthDate = formatter.date(from: birthday)
        age = birthDate!.age
    }

}

