//
//  ViewController.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/6/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        //FBSDKAccessToken.setCurrentAccessToken(nil)

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            // User is already logged in, do work such as go to next view controller.
            returnUserData()
//            let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("dashboardViewController")
//            self.showViewController(vc as! UIViewController, sender: vc)
            
        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            view.addSubview(loginView)
            loginView.center = view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        //loginButtonDidLogOut(nil)
    }
    
    // Facebook Delegate Methods
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil) {
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email") {
                returnUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        
        FBSDKAccessToken.setCurrentAccessToken(nil)
        FBSDKProfile.setCurrentProfile(nil)
        
        let manager = FBSDKLoginManager()
        manager.logOut()
    }
    
    func returnUserData() {
//        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
//        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
//            if ((error) != nil) {
//                // Process error
//                print("Error: \(error)")
//            } else {
//                print("fetched user: \(result)")
//                let userName : NSString = result.valueForKey("name") as! NSString
//                print("User Name is: \(userName)")
//                //let userEmail : NSString = result.valueForKey("email") as! NSString
//                //print("User Email is: \(userEmail)")
//            }
//        })
        var dict : NSDictionary!
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
            if (error == nil){
                dict = result as! NSDictionary
                //print(result)
                print(dict)
                //NSLog(dict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
            }
        })
        
        // trying to get friends list
        let fbRequest = FBSDKGraphRequest(graphPath:"/me/taggable_friends", parameters: nil);
        fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            if (error == nil) {
                print("Friends are : \(result)")
            } else {
                print("Error Getting Friends \(error)");
            }
        }
        
    }
}

