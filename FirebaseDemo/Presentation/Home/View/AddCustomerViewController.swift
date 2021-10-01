//
//  AddCustomerViewController.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 30/09/2021.
//

import UIKit
import Resolver
import ActionSheetPicker_3_0

class AddCustomerViewController: UIViewController, ErrorAlertRenderer, ActivityIndicatorRenderer {
    
    @Injected var viewModel: AddCustomerViewModel
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var dateOfBirthStackView: UIStackView!
    @IBOutlet var dateOfBirthTextField: UITextField!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    private var datePicker: ActionSheetDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setDatePicker()
        viewModel.state.observe(on: self) { [weak self] in
            self?.render(state: $0)
        }
    }
    
    private func configureNavigationBar() {
        self.title = "Creación de cliente"
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.closeView))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
    }
    
    private func setDatePicker() {
        let doneBlock: ActionDateDoneBlock = { [weak self] _, date, _ in
            self?.viewModel.dateOfBirth = date as? Date
            self?.setDateOfBirthTextFieldText()
        }
        datePicker = ActionSheetDatePicker(title: "",
                                           datePickerMode: .date,
                                           selectedDate: Date(),
                                           doneBlock: doneBlock,
                                           cancel: nil,
                                           origin: self.view)
        datePicker?.locale = Locale(identifier: "es")
        datePicker?.maximumDate = Date()
        
        let tapRecognizer = UITapGestureRecognizer(target: datePicker, action: #selector(datePicker?.show))
        dateOfBirthStackView.addGestureRecognizer(tapRecognizer)
    }
    
    private func render(state: AddCustomerViewModel.State) {
        var isLoading = false
        var buttonEnabled = false
        switch state {
        case .initial:
            break
        case .readyToCreate:
            buttonEnabled = true
        case .creating:
            isLoading = true
        case .customerCreated:
            closeView()
        case .error(let error):
            showError(message: error.localizedDescription)
        }
        setActivityIndicator(isLoading)
        createButton.isEnabled = buttonEnabled
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        var text = sender.text?.trimmingCharacters(in: .whitespaces)
        text = text?.isEmpty == false ? text : nil
        switch sender {
        case firstNameTextField:
            viewModel.firstName = text
        case lastNameTextField:
            viewModel.lastName = text
        default:
            break
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        view.endEditing(false)
        viewModel.createCustomer()
    }
    
    private func setDateOfBirthTextFieldText() {
        if let date = viewModel.dateOfBirth {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateOfBirthTextField.text = dateFormatter.string(from: date)
        } else {
            dateOfBirthTextField.text = nil
        }
    }

    @objc private func closeView() {
        self.dismiss(animated: true)
    }
}
