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
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

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
                print("AYE: Unable to authenticate with Facebook - \(error)")
            }else if result?.isCancelled == true{
                print("AYE: User cancelled authentication")
            }else {
                print("AYE: User authenticated with facebook")
                let creditential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(creditential)
            }
        }
        
    }
    
    func firebaseAuth(_ creditential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: creditential, completion: { (user, error) in
            if error != nil {
                print("AYE: Unable to authenticate with firebase")
            } else{
                print("AYE: Successfully authenitcated with firebase")
                
            }
            
        })
    }

    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailField.text, let password = passwordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("AYE: User authenticated with eamil and firebase")
                } else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil{
                            print("AYE: Unable to authenticate user with firebase ")
                        } else{
                            print("AYE: Successfully authenticated with firebase")
                        }
                    })
                }
            })
        }
        
    }

}

