//
//  DashboardViewController.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/8/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DashboardDelegate {
    var myOpenFavors : [String] = []//["open favor 1", "open favor 2", "open favor 3"]
    var myAcceptedFavors : [String] = []
    var myRequestedFavors : [String] = []


    @IBOutlet weak var listItems: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listItems.dataSource = self
        listItems.delegate = self
        //listItems.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        if (indexPath.section == 0) {
            cell.textLabel?.text = myOpenFavors[indexPath.row]
        } else if (indexPath.section == 1) {
            cell.textLabel?.text = myAcceptedFavors[indexPath.row]
        } else {
            cell.textLabel?.text = myRequestedFavors[indexPath.row]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return myOpenFavors.count
        } else if (section == 1) {
            return myAcceptedFavors.count
        } else {
            return myRequestedFavors.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func refresh() {
        print("submitted favor!")
        myOpenFavors.append("new favor 1!")
        myOpenFavors.append("new favor 2!")

        print(myOpenFavors)
        listItems.reloadData()
        
    }
    
    func refreshOpenFavors(openFavor: String) {
        myOpenFavors.append(openFavor)
        listItems.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "pushCreateFavorSegue") {
            let viewController:CreateFavorViewController = segue.destinationViewController as! CreateFavorViewController
            viewController.delegate = self
        }
    }
    
    
    //    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    //        // Return false if you do not want the specified item to be editable.
    //        return true
    //    }
    
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    

}
