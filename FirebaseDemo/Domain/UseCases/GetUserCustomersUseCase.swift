//
//  GetUserCustomersUseCase.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import Foundation
import PromiseKit
import Resolver

protocol GetUserCustomersUseCase {
    func execute() -> Promise<[Customer]>
}

final class GetUserCustomersUseCaseImpl: GetUserCustomersUseCase {
    @Injected var userRepository: UserRepository
    @Injected var customerRepository: CustomerRepository
        
    func execute() -> Promise<[Customer]> {
        let uid: String
        do {
            uid = try userRepository.getUserID()
        } catch {
            return .init(error: error)
        }
        return customerRepository.getCustomersCreatedBy(uid: uid)
    }
}
