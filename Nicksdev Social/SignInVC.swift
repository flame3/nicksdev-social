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
import SwiftKeychainWrapper



class SignInVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        }
        
        
    

    // segues to be performed at startup have to be in viewDidAppear because viewDidLoad is to early
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: signInSegue, sender: nil)
        }
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
                if let user = user{
                    //here we are storing user data into a dictionary so that we can show what provider the user used.
                    // this line is different because without it being creditial it will always default to firebase so we get the creditential from our facebook sign in 
                    let userData = ["provider": creditential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
            }
            
        
        
        })
    }

    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailField.text, let password = passwordField.text{
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("AYE: User authenticated with eamil and firebase")
                    if let user = user{
                        let userData = ["provider": user.providerID]
                    self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else{
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil{
                            print("AYE: Unable to authenticate user with firebase ")
                        } else{
                            print("AYE: Successfully authenticated with firebase")
                            if let user = user{
                                let userData = ["provider": user.providerID]
                            self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
        
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
         KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: signInSegue, sender: nil)
    }

}

