//
//  Repositories+Injection.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerRepositories() {
        register { UserRepositoryImpl() as UserRepository }.scope(.application)
        register { CustomerRepositoryImpl() as CustomerRepository }.scope(.application)
    }
}
