//
//  CreateFavor.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/10/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//

import UIKit

protocol DashboardDelegate {
    func refresh()
    func refreshOpenFavors(favor: String)
}

class CreateFavorViewController: UIViewController {
    var delegate : DashboardDelegate?

    @IBOutlet weak var favorInputTextField: UITextField!
    @IBOutlet weak var favorDueDateInputPicker: UIDatePicker!
    @IBOutlet weak var favorPriceInputField: UITextField!
    
    @IBAction func submitFavor(sender: AnyObject) {
        //delegate?.refresh()
        if let favor = favorInputTextField.text {
            delegate?.refreshOpenFavors(favor)
        }
        
        //self.dismissViewControllerAnimated(true, completion: {})
//        let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let navigationController : UINavigationController = mainStoryboard.instantiateViewControllerWithIdentifier("navigationController") as! UINavigationController
//        self.presentViewController(navigationController, animated: true, completion: nil)
        
        self.navigationController?.popViewControllerAnimated(true)
    }


}
