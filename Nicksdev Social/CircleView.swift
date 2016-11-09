//
//  FancyProfileImage.swift
//  Nicksdev Social
//
//  Created by nic on 31/10/2016.
//  Copyright © 2016 nicksdev. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
        
    }

}
