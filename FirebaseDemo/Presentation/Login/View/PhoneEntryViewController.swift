//
//  PhoneEntryViewController.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 28/09/2021.
//

import UIKit
import Resolver

final class PhoneEntryViewController: UIViewController, ErrorAlertRenderer, ActivityIndicatorRenderer {
    
    @Injected var viewModel: PhoneEntryViewModel
    
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var sendSMSCodeButton: UIButton!
    
    private var phoneNumber: String? {
        didSet {
            sendSMSCodeButton.isEnabled = phoneNumber != nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Iniciar sesión"
        viewModel.state.observe(on: self) { [weak self] in
            self?.render(state: $0)
        }
    }
    
    private func render(state: PhoneEntryViewModel.State) {
        var isLoading = false
        switch state {
        case .initial:
            break
        case .loading:
            isLoading = true
        case .success:
            goToVerificationView()
        case .error(let error):
            showError(message: error.localizedDescription)
        }
        setActivityIndicator(isLoading)
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        if let text = sender.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty {
            self.phoneNumber = text
        } else {
            self.phoneNumber = nil
        }
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let phoneNumber = phoneNumber else {
            return
        }
        view.endEditing(false)
        viewModel.verify(phoneNumber: phoneNumber)
    }
    
    private func goToVerificationView() {
        guard let phoneNumber = phoneNumber else {
            return
        }
        let vc = PhoneVerificationViewController(nib: R.nib.phoneVerificationView)
        vc.phoneNumber = phoneNumber
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhoneEntryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
