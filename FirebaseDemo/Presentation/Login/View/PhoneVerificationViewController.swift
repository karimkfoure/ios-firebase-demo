//
//  PhoneVerificationViewController.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 29/09/2021.
//

import UIKit
import Resolver

final class PhoneVerificationViewController: UIViewController, ErrorAlertRenderer, ActivityIndicatorRenderer {
    
    var phoneNumber: String!
    @Injected var viewModel: PhoneVerificationViewModel

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var verificationCodeTextField: UITextField!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var verifyPhoneNumberButton: UIButton!
    
    private var verificationCode: String? {
        didSet {
            verifyPhoneNumberButton.isEnabled = verificationCode != nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Iniciar sesión"
        titleLabel.text = "Introduce el código de seis dígitos que hemos enviado a " + phoneNumber
        viewModel.state.observe(on: self) { [weak self] in
            self?.render(state: $0)
        }
    }
    
    private func render(state: PhoneVerificationViewModel.State) {
        var isLoading = false
        switch state {
        case .initial:
            break
        case .loading:
            isLoading = true
        case .success:
            goToHomeView()
        case .error(let error):
            showError(message: error.localizedDescription)
        }
        setActivityIndicator(isLoading)
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        if let text = sender.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty {
            self.verificationCode = text
        } else {
            self.verificationCode = nil
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let verificationCode = verificationCode else {
            return
        }
        view.endEditing(false)
        viewModel.verify(phoneNumber: phoneNumber, smsCode: verificationCode)
    }
    
    private func goToHomeView() {
        let vc = CustomersListTableViewController(nib: R.nib.customersListTableView)
        let navVC = UINavigationController(rootViewController: vc)
        view.window?.rootViewController = navVC
        view.window?.makeKeyAndVisible()
    }
}

extension PhoneVerificationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
