//
//  DashboardViewController.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/8/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//
import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DashboardDelegate {
    @IBOutlet weak var listItems: UITableView!
    
    var myOpenFavors : [String] = []
    var myAcceptedFavors : [String] = ["You haven't accepted any favors yet!"]
    var myRequestedFavors : [String] = ["No one has picked up any of your favors yet!"]
    var image : UIImage!
    var profilePicUrl = ""
    var displayName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listItems.dataSource = self
        listItems.delegate = self
        
        displayUserInfo(NSURL(string: profilePicUrl)!)
        print("profilePicUrl= \(profilePicUrl)")
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
        switch(section) {
        case 0:
            return myOpenFavors.count
        case 1:
            return myAcceptedFavors.count
        default:
            return myRequestedFavors.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int)->String? {
        switch(section) {
        case 0:
            return "My Open Favors"
        case 1:
            return "My Accepted Favors"
        case 2:
            return "Favors my Friends are Fulfilling"
        default:
            return ""
        }
    }
    
    func refreshOpenFavors(openFavor: String, deadline: String) {
        myOpenFavors.append(openFavor + " by " + deadline)
        listItems.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "pushCreateFavorSegue") {
            let viewController:CreateFavorViewController = segue.destinationViewController as! CreateFavorViewController
            viewController.delegate = self
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func displayUserInfo(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        print("url: \(url)")
        getDataFromUrl(url) { (data, response, error)  in dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.image = UIImage(data: data)!
                self.image = self.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: self.image, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                self.navigationItem.title = "Welcome Back, " + self.displayName + "!"
            }
        }
    }
}
