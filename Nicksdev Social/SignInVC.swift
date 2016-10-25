//
//  ViewController.swift
//  Nicksdev Social
//
//  Created by nic on 24/10/2016.
//  Copyright © 2016 nicksdev. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase


class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func fbButtonTapped(_ sender: AnyObject) {
        
        let FacebookLogin = FBSDKLoginManager()
        FacebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil{
                print("NICK: Unable to authenticate with Facebook")
            }else if result?.isCancelled == true{
                print("NICK: User cancelled authentication")
            }else {
                print("NICK: User authenticated with facebook")
                let creditential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(creditential)
            }
        }
        
    }
    
    func firebaseAuth(_ creditential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: creditential, completion: { (user, error) in
            if error != nil {
                print("NICK: Unable to authenticate with firebase")
            } else{
                print("Successfully authenitcated with firebase")
                
            }
            
        })
    }


}

