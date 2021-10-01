//
//  UserRepositoryImpl.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 29/09/2021.
//

import Foundation
import PromiseKit
import FirebaseAuth

final class UserRepositoryImpl: UserRepository {
    
    private var verificationIDs: [String: String] = [:]
    
    func getUserID() throws -> String {
        guard let uid = Auth.auth().currentUser?.uid else {
            throw UserRepositoryErrors.userIDUnavailable
        }
        return uid
    }
    
    func isLoggedIn() -> Bool {
        Auth.auth().currentUser != nil
    }
    
    func verify(phoneNumber: String) -> Promise<Void> {
        guard phoneNumber.count > 5 else {
            return .init(error: UserRepositoryErrors.verifyPhoneNumberInvalidFormat)
        }

        return Promise { seal in
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber,
                                                           uiDelegate: nil) { verificationID, error in
                if let vID = verificationID {
                    seal.fulfill(vID)
                } else if let error = error {
                    seal.reject(error)
                } else {
                    seal.reject(UserRepositoryErrors.verifyPhoneNumberGenericError)
                }
            }
        }.done { verificationID in
            self.verificationIDs[phoneNumber] = verificationID
        }
    }
    
    func signIn(phoneNumber: String, smsCode: String) -> Promise<Void> {
        guard let verificationID = verificationIDs[phoneNumber] else {
            return .init(error: UserRepositoryErrors.signInVerificationIDUnavailable)
        }
        return Promise { seal in
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID,
                                                                     verificationCode: smsCode)
            Auth.auth().signIn(with: credential) { result, error in
                if result != nil {
                    seal.fulfill_()
                } else if let error = error {
                    seal.reject(error)
                } else {
                    seal.reject(UserRepositoryErrors.signInGenericError)
                }
            }
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
}
