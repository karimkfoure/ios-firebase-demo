//
//  AddCustomerViewModel.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import Foundation
import Resolver

class AddCustomerViewModel {
    enum State {
        case initial
        case readyToCreate
        case creating
        case customerCreated
        case error(Error)
    }
    
    @Injected var addUserCustomerUseCase: AddUserCustomerUseCase

    let state: Observable<State> = Observable(.initial)

    var firstName: String? {
        didSet {
            checkIfReadyToCreate()
        }
    }
    var lastName: String? {
        didSet {
            checkIfReadyToCreate()
        }
    }
    var dateOfBirth: Date? {
        didSet {
            checkIfReadyToCreate()
        }
    }
    
    private func checkIfReadyToCreate() {
        if firstName != nil, lastName != nil, dateOfBirth != nil {
            state.value = .readyToCreate
        } else {
            state.value = .initial
        }
    }
    
    func createCustomer() {
        state.value = .creating

        guard let firstName = firstName, let lastName = lastName, let dateOfBirth = dateOfBirth else {
            self.state.value = .error(Errors.incompleteFields)
            return
        }
        
        let customer = Customer(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth)
        
        addUserCustomerUseCase.execute(customer: customer)
            .done { _ in
                self.state.value = .customerCreated
            }
            .catch { error in
                self.state.value = .error(error)
            }
    }
    
    enum Errors: Error {
        case incompleteFields
    }
}
