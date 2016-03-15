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
    
    var myOpenFavors : [String] = []//["open favor 1", "open favor 2", "open favor 3"]
    var myAcceptedFavors : [String] = ["You haven't accepted any favors yet!"]
    var myRequestedFavors : [String] = ["No one has picked up any of your favors yet!"]
    
    var profilePicUrl = ""
    var image : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listItems.dataSource = self
        listItems.delegate = self
        
        downloadImage(NSURL(string: profilePicUrl)!)
        
        //image = UIImage(named: "tmp_pic.jpeg")!
        //image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
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
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL){
        print("Download Started")
        print("lastPathComponent: " + (url.lastPathComponent ?? ""))
        print("url: \(url)")
        getDataFromUrl(url) { (data, response, error)  in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("Download Finished")
                self.image = UIImage(data: data)!
                self.image = self.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: self.image, style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
            }
        }
    }
}
