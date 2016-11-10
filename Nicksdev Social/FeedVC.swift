//
//  FeedVC.swift
//  Nicksdev Social
//
//  Created by nic on 25/10/2016.
//  Copyright © 2016 nicksdev. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImage: CircleView!
    @IBOutlet weak var captionTF: FancyField!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    var imageSelected = false
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots{
                    print("SNAP:   \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject>{
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: feedCellID) as? PostCell{
        
            if let img = FeedVC.imageCache.object(forKey: post.imageURL as NSString){
                cell.configureCell(post: post, img: img)
                return cell
            }else {
                cell.configureCell(post: post)
                return cell
            }
            
        }else {
            return PostCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            imageSelected = true
            addImage.image = image
        } else {
            print("AYE: valid image wasn't used")
                }
        imagePicker.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func postBtnTapped(_ sender: AnyObject) {
    }
    
    @IBAction func addImageTapped(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
        
        guard let caption = captionTF.text, caption != "", imageSelected == true else{
            print("AYE: Caption must be entered")
            return
        }
        guard let img = addImage.image else{
            print("AYE: Image must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2){
            let imageUID = NSUUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            DataService.ds.REF_POST_IMAGES.child(imageUID).put(imgData, metadata: metaData) { (metaData, error) in
                if error != nil{
                    print("AYE: Unable to upload image to firebase console")
                } else{
                    print("AYE: Successfully loaded image to firebase storage")
                    let downloadURL = metaData?.downloadURL()?.absoluteString
                }
            }
            
        }
        
    }
    
    @IBAction func signOut(_ sender: AnyObject) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: signOutSegue, sender: nil)
    }

}
