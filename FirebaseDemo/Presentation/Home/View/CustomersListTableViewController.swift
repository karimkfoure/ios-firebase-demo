//
//  CustomersListTableViewController.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 29/09/2021.
//

import UIKit
import Resolver

class CustomersListTableViewController: UITableViewController, ErrorAlertRenderer, ActivityIndicatorRenderer {
    
    @Injected var viewModel: CustomersListViewModel
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        self.tableView.register(R.nib.customersListItemCell)
        viewModel.state.observe(on: self) { [weak self] in
            self?.render(state: $0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserCustomers()
    }
    
    private func configureNavigationBar() {
        self.title = "Clientes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let logoutBarButtonItem = UIBarButtonItem(title: "Cerrar sesión", style: .done, target: viewModel, action: #selector(viewModel.signOut))
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.presentAddCustomerView))
        self.navigationItem.leftBarButtonItem = logoutBarButtonItem
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }

    private func render(state: CustomersListViewModel.State) {
        var isLoading = false
        switch state {
        case .initial:
            break
        case .loading:
            isLoading = true
        case .success:
            tableView.reloadData()
        case .error(let error):
            showError(message: error.localizedDescription)
        case .signedOut:
            goToLoginView()
        }
        setActivityIndicator(isLoading)
    }
    
    private func goToLoginView() {
        let vc = PhoneEntryViewController(nib: R.nib.phoneEntryView)
        let navVC = UINavigationController(rootViewController: vc)
        view.window?.rootViewController = navVC
        view.window?.makeKeyAndVisible()
    }
    
    @objc private func presentAddCustomerView() {
        let vc = AddCustomerViewController(nib: R.nib.addCustomerView)
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.customers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.customersListItemCell, for: indexPath)!
        cell.fill(with: viewModel.customers[indexPath.row])
        return cell
    }
}
