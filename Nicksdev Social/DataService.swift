//
//  DataService.swift
//  Nicksdev Social
//
//  Created by nic on 2/11/2016.
//  Copyright © 2016 nicksdev. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()


class DataService{
    static let ds = DataService()
    // DB references
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    
    // Storage Reference
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-imgs")
    
    
    var REF_BASE: FIRDatabaseReference{
        return _REF_BASE
    }
    var REF_POSTS: FIRDatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS: FIRDatabaseReference{
        return _REF_USERS
    }
    var REF_USERS_CURRENT: FIRDatabaseReference{
        //let uid = KeychainWrapper.stringForKey(KEY_UID)
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    var REF_POST_IMAGES: FIRStorageReference{
        return _REF_POST_IMAGES
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        // used updateChild instead of setValue because set value will wipe out existing data while update child will only add or create
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
}
