//
//  CustomerRepositoryImpl.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import Foundation
import PromiseKit
import FirebaseFirestore
import FirebaseFirestoreSwift

final class CustomerRepositoryImpl: CustomerRepository {
    
    func getCustomersCreatedBy(uid: String) -> Promise<[Customer]> {
        let query = Firestore.firestore()
            .collection("customers")
            .whereField("createdBy", isEqualTo: uid)
            .order(by: "creationDate", descending: true)

        return Promise<[QueryDocumentSnapshot]> { seal in
            query.getDocuments() { querySnapshot, error in
                if let snapshot = querySnapshot {
                    seal.fulfill(snapshot.documents)
                } else if let error = error {
                    seal.reject(error)
                } else {
                    seal.reject(CustomerRepositoryErrors.firestoreGenericError)
                }
            }
        }.compactMapValues { docSnapshot in
            try docSnapshot.data(as: CustomerDTO.self)?.toDomain()
        }
    }
    
    func addCustomer(customer: Customer, createdBy uid: String) -> Promise<Void> {
        let customerDTO = CustomerDTO(firstName: customer.firstName,
                                      lastName: customer.lastName,
                                      dateOfBirth: customer.dateOfBirth,
                                      createdBy: uid,
                                      creationDate: Date())
        var ref: DocumentReference? = nil

        return Promise { seal in
            ref = try Firestore.firestore()
                .collection("customers")
                .addDocument(from: customerDTO) { error in
                    if let error = error {
                        seal.reject(error)
                    } else {
                        debugPrint(ref?.documentID)
                        seal.fulfill_()
                    }
                }
        }
    }
}
