//
//  ViewModels+Injection.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerViewModels() {
        register { PhoneEntryViewModel() }
        register { PhoneVerificationViewModel() }
        register { CustomersListViewModel() }
        register { AddCustomerViewModel() }
    }
}
