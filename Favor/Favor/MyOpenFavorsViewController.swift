//
//  MyOpenFavorsViewController.swift
//  Favor
//
//  Created by Gonimah, Mayada on 4/13/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//

import UIKit

class MyOpenFavorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DashboardDelegate {
    @IBOutlet weak var listItems: UITableView!
    var myOpenFavors : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listItems.dataSource = self
        listItems.delegate = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myOpenFavorCell", forIndexPath: indexPath)
            cell.textLabel?.text = myOpenFavors[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOpenFavors.count
    }
    
    func refreshOpenFavors(openFavor: String, deadline: String) {
        myOpenFavors.append(openFavor + " by " + deadline)
        listItems.reloadData()
        print(myOpenFavors)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "presentCreateFavorSegue") {
            let viewController:CreateFavorViewController = segue.destinationViewController as! CreateFavorViewController
            viewController.delegate = self
        }
    }
}
