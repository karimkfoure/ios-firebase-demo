//
//  CustomerRepository.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import Foundation
import PromiseKit

public enum CustomerRepositoryErrors: Error {
    case firestoreGenericError
}

protocol CustomerRepository {
    func getCustomersCreatedBy(uid: String) -> Promise<[Customer]>
    func addCustomer(customer: Customer, createdBy: String) -> Promise<Void>
}
