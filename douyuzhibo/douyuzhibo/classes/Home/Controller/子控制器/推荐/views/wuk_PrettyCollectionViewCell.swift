//
//  wuk_PrettyCollectionViewCell.swift
//  douyuzhibo
//
//  Created by wukeng on 17/1/15.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit



class wuk_PrettyCollectionViewCell:UICollectionViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let labelMaxW : CGFloat = bounds.width / 2.0 - 20.0
        if authorLabel.bounds.width >= labelMaxW {
            let frame = authorLabel.frame
            authorLabel.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: labelMaxW, height: frame.size.height)
        }
        if locationLabel.bounds.width >= labelMaxW {
            let frame = authorLabel.frame
            authorLabel.frame = CGRect(x: bounds.width / 2.0, y: frame.origin.y, width: labelMaxW, height: frame.size.height)
        }

    }
    
    
}

