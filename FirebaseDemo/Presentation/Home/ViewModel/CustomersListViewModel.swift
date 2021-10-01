//
//  CustomersListViewModel.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 29/09/2021.
//

import Foundation
import Resolver

class CustomersListViewModel {
    enum State {
        case initial
        case loading
        case success
        case error(Error)
        case signedOut
    }
    
    @Injected var userRepository: UserRepository
    @Injected var getUserCustomersUseCase: GetUserCustomersUseCase

    let state: Observable<State> = Observable(.initial)
    private(set) var customers: [CustomersListItemViewModel] = []
    
    func getUserCustomers() {
        state.value = .loading
        getUserCustomersUseCase.execute()
            .mapValues {
                CustomersListItemViewModel(customer: $0)
            }
            .done { customers in
                self.customers = customers
                self.state.value = .success
            }
            .catch { error in
                self.state.value = .error(error)
            }
    }
    
    @objc func signOut() {
        do {
            try userRepository.signOut()
            self.state.value = .signedOut
        } catch {
            self.state.value = .error(error)
        }
    }
}
