//
//  CustomerDTO.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import Foundation

struct CustomerDTO: Codable {
    let firstName: String
    let lastName: String
    let dateOfBirth: Date
    let createdBy: String
    let creationDate: Date
}

extension CustomerDTO {
    func toDomain() -> Customer {
        Customer(firstName: firstName,
                 lastName: lastName,
                 dateOfBirth: dateOfBirth)

//        Customer(firstName: firstName,
//                 lastName: lastName,
//                 dateOfBirth: dateOfBirth,
//                 createdBy: createdBy,
//                 creationDate: creationDate)
    }
}
