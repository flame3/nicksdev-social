//
//  FancyLogo.swift
//  Nicksdev Social
//
//  Created by nic on 25/10/2016.
//  Copyright © 2016 nicksdev. All rights reserved.
//

import UIKit

class FancyLogo: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.9).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 10.0
        layer.shadowOffset = CGSize(width: 4.0, height: 1.0)
        
    }

}
