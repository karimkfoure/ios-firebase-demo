//
//  UseCases+Injection.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerUseCases() {
        register { GetUserCustomersUseCaseImpl() as GetUserCustomersUseCase }
        register { AddUserCustomerUseCaseImpl() as AddUserCustomerUseCase }
    }
}
