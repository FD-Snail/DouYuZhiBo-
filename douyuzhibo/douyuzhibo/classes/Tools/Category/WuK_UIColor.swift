//
//  WuK_UIColor.swift
//  douyuzhibo
//
//  Created by wukeng on 17/1/10.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
}
