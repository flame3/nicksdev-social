//
//  DataService.swift
//  Nicksdev Social
//
//  Created by nic on 2/11/2016.
//  Copyright © 2016 nicksdev. All rights reserved.
//

import Foundation
import FirebaseDatabase

let DB_BASE = FIRDatabase.database().reference()


class DataService{
    static let ds = DataService()
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    
    var REF_BASE: FIRDatabaseReference{
        return _REF_BASE
    }
    var REF_POSTS: FIRDatabaseReference{
        return _REF_POSTS
    }
    var REF_USERS: FIRDatabaseReference{
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        // used updateChild instead of setValue because set value will wipe out existing data while update child will only add or create
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
}
