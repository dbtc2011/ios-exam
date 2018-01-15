//
//  DateExtension.swift
//  PersonsList
//
//  Created by Mark Louie Angeles on 16/01/2018.
//  Copyright © 2018 Mark Louie Angeles. All rights reserved.
//

import Foundation

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
}
