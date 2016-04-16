//
//  CreateFavor.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/10/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//

import UIKit
import Firebase

protocol DashboardDelegate {
    func refreshOpenFavors(favor: String, deadline: String)
}

class CreateFavorViewController: UIViewController {
    @IBOutlet weak var favorInputTextField: UITextField!
    @IBOutlet weak var favorDueDateInputPicker: UIDatePicker!
    @IBOutlet weak var favorPriceInputField: UITextField!
    
    let ref = Firebase(url:"https://dummyfavor.firebaseio.com/favor")
    var delegate : DashboardDelegate?
    var favorDeadline = ""
    let dateFormatter = NSDateFormatter()

    @IBAction func submitFavor(sender: AnyObject) {
        if let favorName = favorInputTextField.text {
            if favorDeadline == "" {
                dateFormatter.dateStyle = .FullStyle
                favorDeadline = dateFormatter.stringFromDate(NSDate())
                
            }
            delegate?.refreshOpenFavors(favorName, deadline: self.favorDeadline)
            // add favor to firebase db
            let favor = Favor(name: favorName, addedByUser: "dummy", completed: false)
            let favorRef = self.ref.childByAppendingPath(favorName)
            favorRef.setValue(favor.toAnyObject())
        }
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        dateFormatter.dateStyle = .FullStyle
        let strDate = dateFormatter.stringFromDate(favorDueDateInputPicker.date)
        self.favorDeadline = strDate
    }
    @IBAction func cancelToDismissViewModally(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func getCurrentDate() -> String {
        return ""
    }
}