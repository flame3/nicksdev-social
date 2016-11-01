//
//  PostCell.swift
//  Nicksdev Social
//
//  Created by nic on 31/10/2016.
//  Copyright © 2016 nicksdev. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLBL: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var captionTV: UITextView!
    @IBOutlet weak var likesLBL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
