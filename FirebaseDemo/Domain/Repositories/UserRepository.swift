//
//  UserRepository.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 29/09/2021.
//

import Foundation
import PromiseKit

public enum UserRepositoryErrors: Error {
    case userIDUnavailable
    case verifyPhoneNumberInvalidFormat
    case verifyPhoneNumberGenericError
    case signInVerificationIDUnavailable
    case signInGenericError
}

protocol UserRepository {
    func getUserID() throws -> String
    func isLoggedIn() -> Bool
    func verify(phoneNumber: String) -> Promise<Void>
    func signIn(phoneNumber: String, smsCode: String) -> Promise<Void>
    func signOut() throws
}
