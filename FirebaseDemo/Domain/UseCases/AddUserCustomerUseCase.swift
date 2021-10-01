//
//  AddUserCustomerUseCase.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 01/10/2021.
//

import Foundation
import PromiseKit
import Resolver

protocol AddUserCustomerUseCase {
    func execute(customer: Customer) -> Promise<Void>
}

final class AddUserCustomerUseCaseImpl: AddUserCustomerUseCase {
    @Injected var userRepository: UserRepository
    @Injected var customerRepository: CustomerRepository

    func execute(customer: Customer) -> Promise<Void> {
        let uid: String
        do {
            uid = try userRepository.getUserID()
        } catch {
            return .init(error: error)
        }
        return customerRepository.addCustomer(customer: customer, createdBy: uid)
    }
}
