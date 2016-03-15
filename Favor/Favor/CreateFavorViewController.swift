//
//  CreateFavor.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/10/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//

import UIKit

protocol DashboardDelegate {
    func refreshOpenFavors(favor: String)
}

class CreateFavorViewController: UIViewController {
    var delegate : DashboardDelegate?

    @IBOutlet weak var favorInputTextField: UITextField!
    @IBOutlet weak var favorDueDateInputPicker: UIDatePicker!
    @IBOutlet weak var favorPriceInputField: UITextField!

    @IBAction func submitFavor(sender: AnyObject) {
        if let favor = favorInputTextField.text {
            delegate?.refreshOpenFavors(favor)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
}
