//
//  ErrorAlertRenderer.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import UIKit

protocol ErrorAlertRenderer {
    func showError(message: String?)
}

extension ErrorAlertRenderer where Self: UIViewController {
    func showError(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
