//
//  ViewController.swift
//  Favor
//
//  Created by Gonimah, Mayada on 3/6/16.
//  Copyright © 2016 Gonimah, Mayada. All rights reserved.
import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            getFBdata()
        } else {
            addFacebookAndSignUpButtons()
        }
    }
    
    // Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        loginButton.hidden = true
        print("User Logged In")
        if ((error) != nil) {
            print("Problem logging in: \(error)")
        } else if result.isCancelled {
            print("Login cancelled: \(result)")
        } else {
            fetchUserData()
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
        // get user's friends
        let fbRequest = FBSDKGraphRequest(graphPath:"/me/friends", parameters: nil);
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
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(small), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
            if (error == nil){
                dict = result as! NSDictionary
                let picture = dict["picture"] as? Dictionary<String, AnyObject>
                let data = picture!["data"] as? Dictionary<String, AnyObject>
                let url = data!["url"] as? String
                let userDisplayName = dict!["first_name"] as? String
                
                let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
                let myOpenFavorsViewController = tabBarController.viewControllers![0] as! MyOpenFavorsViewController
                myOpenFavorsViewController.displayName = userDisplayName!
                myOpenFavorsViewController.profilePicUrl = url!
                self.presentViewController(tabBarController, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func loginButtonAction(sender: AnyObject) {
        // todo email authentication for non-facebook users
        let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController") as! UITabBarController
        tabBarController.viewControllers![0] as! MyOpenFavorsViewController
        self.presentViewController(tabBarController, animated: true, completion: nil)
    }
    
    func signUpButtonAction(sender:UIButton!) {
        print("sign up is still todo")
    }
    
    func addFacebookAndSignUpButtons() {
        let facebookLoginButton : FBSDKLoginButton = FBSDKLoginButton()
        facebookLoginButton.readPermissions = ["public_profile", "email", "user_friends"]
        facebookLoginButton.delegate = self
        
        view.addSubview(facebookLoginButton)
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let facebookLoginButtonHorizontalConstraint = NSLayoutConstraint(item: facebookLoginButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: loginButton, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        view.addConstraint(facebookLoginButtonHorizontalConstraint)
        
        let facebookLoginButtonVerticalConstraint = NSLayoutConstraint(item: facebookLoginButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: loginButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10)
        view.addConstraint(facebookLoginButtonVerticalConstraint)
        
        let signUpButton = UIButton(type: UIButtonType.System) as UIButton
        signUpButton.setTitle("Sign up", forState: UIControlState.Normal)
        signUpButton.titleLabel?.font = UIFont(name: "Avenir Book", size: 15.0)
        signUpButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        signUpButton.addTarget(self, action: "signUpButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)
        
        let signUpButtonHorizontalConstraint = NSLayoutConstraint(item: signUpButton, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: facebookLoginButton, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        view.addConstraint(signUpButtonHorizontalConstraint)
        
        let signUpButtonVerticalConstraint = NSLayoutConstraint(item: signUpButton, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: facebookLoginButton, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10)
        view.addConstraint(signUpButtonVerticalConstraint)
    }

}

