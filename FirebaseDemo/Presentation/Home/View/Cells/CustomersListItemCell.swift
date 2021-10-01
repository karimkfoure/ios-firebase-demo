//
//  CustomersListItemCell.swift
//  FirebaseDemo
//
//  Created by Karím Kfoure on 28/09/2021.
//

import UIKit

class CustomersListItemCell: UITableViewCell {
    
    @IBOutlet var nameValueLabel: UILabel!
    @IBOutlet var dobValueLabel: UILabel!
    @IBOutlet var ageValueLabel: UILabel!
    
    func fill(with viewModel: CustomersListItemViewModel) {
        self.nameValueLabel.text = viewModel.customer.formattedName
        self.dobValueLabel.text = viewModel.customer.formattedDateOfBirth
        self.ageValueLabel.text = viewModel.customer.formattedAge
    }
}
