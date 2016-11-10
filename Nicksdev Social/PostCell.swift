//
//  PostCell.swift
//  Nicksdev Social
//
//  Created by nic on 31/10/2016.
//  Copyright © 2016 nicksdev. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLBL: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionTV: UITextView!
    @IBOutlet weak var likesLBL: UILabel!
    
    var post: Post!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //“Excellence is an art won by training and habituation: we not act rightly because we have virtue or excellence, but rather have these because we have acted rightly; these virtues are formed in man by doing his actions; we are we repeatedly do. Excellence, then, is not an act but a habit.”
    }
    
    func configureCell(post: Post, img: UIImage? = nil){
        self.post = post
        self.captionTV.text = post.caption
        self.likesLBL.text = "\(post.likes)"
        
        
        if img != nil{
            self.postImage.image = img
        }else {
                let ref = FIRStorage.storage().reference(forURL: post.imageURL)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    
                    if error != nil{
                        print("AYE: Unable to download image from Firebase")
                    } else {
                        print("AYE: What's up ")
                        
                        if let imgData = data {
                            if let img = UIImage(data: imgData){
                                self.postImage.image = img
                                FeedVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                            }
                        }
                    }
                })
            
            }
        }
        
        
        
        
}




