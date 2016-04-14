//
//  CreateFavor.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/10/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//

import UIKit

protocol DashboardDelegate {
    func refreshOpenFavors(favor: String, deadline: String)
}

class CreateFavorViewController: UIViewController {
    var delegate : DashboardDelegate?
    @IBOutlet weak var favorInputTextField: UITextField!
    @IBOutlet weak var favorDueDateInputPicker: UIDatePicker!
    @IBOutlet weak var favorPriceInputField: UITextField!
    var favorDeadline = ""

    @IBAction func submitFavor(sender: AnyObject) {
        if let favor = favorInputTextField.text {
            delegate?.refreshOpenFavors(favor, deadline: self.favorDeadline)
        }
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .FullStyle
        let strDate = dateFormatter.stringFromDate(favorDueDateInputPicker.date)
        self.favorDeadline = strDate
    }
    @IBAction func cancelToDismissViewModally(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
