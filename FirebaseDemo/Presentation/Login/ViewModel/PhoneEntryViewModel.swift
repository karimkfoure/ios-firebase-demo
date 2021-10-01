//
//  PhoneEntryViewModel.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 29/09/2021.
//

import Foundation
import Resolver

class PhoneEntryViewModel {
    enum State {
        case initial
        case loading
        case success
        case error(Error)
    }

    @Injected var userRepository: UserRepository

    let state: Observable<State> = Observable(.initial)

    func verify(phoneNumber: String) {
        state.value = .loading
        userRepository.verify(phoneNumber: phoneNumber)
            .done { _ in
                self.state.value = .success
            }
            .catch {
                self.state.value = .error($0)
            }
    }
}
