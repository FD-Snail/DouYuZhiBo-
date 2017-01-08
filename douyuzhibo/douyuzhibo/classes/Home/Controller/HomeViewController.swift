//
//  HomeViewController.swift
//  douyuzhibo
//
//  Created by wukeng on 17/1/8.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       setUpUI()
    }
    
   
}

extension HomeViewController {
    fileprivate func setUpUI(){
        setNavi()
    }
    fileprivate func setNavi(){
        // 1.设置导航栏背景色
        navigationController?.navigationBar.barTintColor = UIColor.orange
        // 2.设置左侧的Item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        // 3.设置右侧的Item
        let size = CGSize(width: 40, height: 40)
        
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "btn_search_clicked", size: size)
        let scanItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "Image_scan_click", size: size)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "btn_history_clicked", size: size)
        navigationItem.rightBarButtonItems = [searchItem,scanItem,historyItem]
    }
}
