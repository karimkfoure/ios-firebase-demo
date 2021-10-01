//
//  PhoneVerificationViewModel.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 29/09/2021.
//

import Foundation
import Resolver

class PhoneVerificationViewModel {
    enum State {
        case initial
        case loading
        case success
        case error(Error)
    }
    
    @Injected var userRepository: UserRepository

    let state: Observable<State> = Observable(.initial)

    func verify(phoneNumber: String, smsCode: String) {
        state.value = .loading
        userRepository.signIn(phoneNumber: phoneNumber, smsCode: smsCode)
            .done { _ in
                self.state.value = .success
            }
            .catch {
                self.state.value = .error($0)
            }
    }
}
