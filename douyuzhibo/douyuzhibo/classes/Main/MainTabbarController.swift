//
//  MainTabbarController.swift
//  douyuzhibo
//
//  Created by wukeng-mac on 2017/1/7.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Video")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Profile")
    }
    private func addChildVC(storyName : String){
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()
        addChildViewController(childVC!)
    }
}
