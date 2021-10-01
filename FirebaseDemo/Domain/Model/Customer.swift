//
//  Customer.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 28/09/2021.
//

import Foundation

struct Customer {
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
//    let createdBy: String
//    let creationDate: Date
}

extension Customer {
    var formattedName: String {
        [lastName, firstName].joined(separator: ", ")
    }
    
    var formattedDateOfBirth: String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd/MM/yyyy"
        return dateformat.string(from: dateOfBirth)
    }
    
    var formattedAge: String {
        let calendar = Calendar.current
        let dob = calendar.dateComponents([.year], from: dateOfBirth)
        let now = calendar.dateComponents([.year], from: Date())
        if let age = calendar.dateComponents([.year], from: dob, to: now).year {
            return "\(age)"
        } else {
            return "-"
        }
    }
}
