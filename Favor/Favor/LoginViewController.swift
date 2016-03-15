//
//  ViewController.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/6/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            fetchUserData()
        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            view.addSubview(loginView)
            loginView.center = view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "goToDashboard") {
//            let navigationController = segue.destinationViewController as! UINavigationController
//            let dashboardViewController = navigationController.topViewController as! DashboardViewController
//            dashboardViewController.tempText = "hi"
//            
//        }
//    }
    
    // Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        loginButton.hidden = true
        print("User Logged In")
        if ((error) != nil) {
            print("Problem logging in: \(error)")
        } else if result.isCancelled {
            print("Login cancelled: \(result)")
        } else {
            //fetchUserData()
            getFBdata()
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
        FBSDKAccessToken.setCurrentAccessToken(nil)
        FBSDKProfile.setCurrentProfile(nil)
        let manager = FBSDKLoginManager()
        manager.logOut()
    }
    
    func fetchUserData() {
        var dict : NSDictionary!
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(small), email"])
            .startWithCompletionHandler({ (connection, result, error) -> Void in
            if (error == nil){
                dict = result as! NSDictionary
//                print(dict)
//                print(dict["picture"]!["data"]!!["url"])
            }
        })
        
        // get taggable friends
        let fbRequest = FBSDKGraphRequest(graphPath:"/me/taggable_friends", parameters: nil);
        fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            if (error == nil) {
                print("Friends are : \(result)")
            } else {
                print("Error Getting Friends \(error)");
            }
        }
    }
    
    func getFBdata() {
        var dict : NSDictionary!
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(small), email"])
            .startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    dict = result as! NSDictionary
                    
                    let navigationController = self.storyboard?.instantiateViewControllerWithIdentifier("navigationController") as! UINavigationController
                    let dashboardViewController = navigationController.topViewController as! DashboardViewController
                    
                    let picture = dict["picture"] as? Dictionary<String, AnyObject>
                    let data = picture!["data"] as? Dictionary<String, AnyObject>
                    let url = data!["url"] as? String
                    
                    dashboardViewController.profilePicUrl = url!
                    self.presentViewController(navigationController, animated: true, completion: nil)
                }
            })
    }
}

