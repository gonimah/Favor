//
//  MyOpenFavorsViewController.swift
//  Favor
//
//  Created by Gonimah, Mayada on 4/13/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//
import UIKit
import Firebase

class MyOpenFavorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DashboardDelegate {
    @IBOutlet weak var listItems: UITableView!
    var myOpenFavors : [Favor] = []
    
    var image : UIImage!
    var profilePicUrl = ""
    var displayName = ""
    let ref = Firebase(url:"https://dummyfavor.firebaseio.com/favor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listItems.dataSource = self
        listItems.delegate = self
        displayUserInfo(NSURL(string: profilePicUrl)!)
    }
    
    override func viewDidAppear(animated: Bool) {
        ref.observeEventType(.Value, withBlock: { snapshot in
            var newItems = [Favor]()
            for item in snapshot.children {
                let favorItem = Favor(snapshot: item as! FDataSnapshot)
                
                newItems.append(favorItem)
            }
            self.myOpenFavors = newItems
            self.listItems.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myOpenFavorCell", forIndexPath: indexPath)
        cell.textLabel?.text = myOpenFavors[indexPath.row].name
        cell.detailTextLabel?.text = "Due on \(myOpenFavors[indexPath.row].deadline)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOpenFavors.count
    }
    
    func refreshOpenFavors(openFavor: Favor) {
        myOpenFavors.append(openFavor)
        listItems.reloadData()
        print(myOpenFavors)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "presentCreateFavorSegue") {
            let viewController:CreateFavorViewController = segue.destinationViewController as! CreateFavorViewController
            viewController.delegate = self
        }
    }
    
    func displayUserInfo(url: NSURL){
        getDataFromUrl(url) { (data, response, error)  in dispatch_async(dispatch_get_main_queue()) { () -> Void in
            guard let data = data where error == nil else { return }
            self.image = UIImage(data: data)!
            self.image = self.image.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            let profilepic = UIImageView(frame: CGRectMake(20, 20, self.view.bounds.width * 0.12 , self.view.bounds.height * 0.06))
            profilepic.image = self.image
            profilepic.layer.masksToBounds = false
            profilepic.layer.cornerRadius = profilepic.frame.height/2
            profilepic.clipsToBounds = true
            self.view.addSubview(profilepic)
            }
        }
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
}
