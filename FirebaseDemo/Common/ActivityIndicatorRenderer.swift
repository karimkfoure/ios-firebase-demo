//
//  ActivityIndicatorRenderer.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import UIKit

protocol ActivityIndicatorRenderer {
    var activityIndicatorView: UIActivityIndicatorView! { get set }
    func setActivityIndicator(_ isLoading: Bool)
}

extension ActivityIndicatorRenderer where Self: UIViewController {
    func setActivityIndicator(_ isLoading: Bool) {
        if isLoading {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}
