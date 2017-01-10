//
//  HomeViewController.swift
//  douyuzhibo
//
//  Created by wukeng on 17/1/8.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    //懒加载
    fileprivate lazy var titilView : TitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titleView = TitleView.init(frame: titleFrame, titles: ["推荐","手游","娱乐","游戏","趣玩"])
        return titleView
    }()
    fileprivate lazy var contentView : PageView = {[weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(PhoneGameViewController())
        childVcs.append(AmusementViewController())
        childVcs.append(GameViewController())
        childVcs.append(IntersetingViewController())
        let content = PageView(frame: frame, childVcs: childVcs, parentControll: self!)
        
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigation和statusBar的时候防止scrollView添加的时候自动调整尺寸
        self.automaticallyAdjustsScrollViewInsets = false
        setUpUI()
    }
}

extension HomeViewController {
    fileprivate func setUpUI(){
        //1 设置导航栏
        setNavi()
        //2 设置标题栏
        view.addSubview(titilView)
        //3. 添加contentView
        view.addSubview(contentView)
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
