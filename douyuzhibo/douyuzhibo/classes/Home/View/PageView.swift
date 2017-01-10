//
//  PageView.swift
//  douyuzhibo
//
//  Created by wukeng on 17/1/10.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit

private let CollectCellID = "PageCollectionViewCellID"

class PageView: UIView {
    
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVC : UIViewController
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let frame = self!.bounds
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.scrollsToTop = false
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CollectCellID)
        return collection
    }()
    init(frame : CGRect, childVcs : [UIViewController] , parentControll : UIViewController) {
        self.childVcs = childVcs
        self.parentVC = parentControll
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

// MARK: - 设置UI
extension PageView{
    fileprivate func setUpUI(){
        //1.将所有的自控制器添加到父控制器中
        for childVc in childVcs {
            parentVC.addChildViewController(childVc)
        }
        //2.添加ScrollView
        addSubview(collectionView)
    }
}

// MARK: - collectionView数据源
extension PageView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}
