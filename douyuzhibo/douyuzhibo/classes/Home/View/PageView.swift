//
//  PageView.swift
//  douyuzhibo
//
//  Created by wukeng on 17/1/10.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit

private let CollectCellID = "PageCollectionViewCellID"

protocol PageViewDelegate : class {
    func pageViewDidScroll(progerss : CGFloat, sourceIndex : Int, targetIndex : Int)
}

class PageView: UIView {
    
    fileprivate var childVcs : [UIViewController]
    fileprivate var parentVC : UIViewController
    fileprivate var isForScrollDelegate : Bool = false
    fileprivate var startOffsetX : CGFloat = 0
    weak var delegate : PageViewDelegate?
    
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
        collection.delegate = self
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
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
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

// MARK: - collectionView代理
extension PageView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForScrollDelegate {
            return
        }
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        
        //判断左划还是右手
        let isright : Bool =  scrollView.contentOffset.x - startOffsetX < 0
        let scrollW = self.bounds.width
        
        if  isright {
            progress = 1 - (scrollView.contentOffset.x / scrollW - floor(scrollView.contentOffset.x / scrollW))
            targetIndex = Int(scrollView.contentOffset.x / scrollW)
            sourceIndex = targetIndex + 1
            if scrollView.contentOffset.x < 0 {
                targetIndex = 0
                sourceIndex = 0
            }
        }
        else{
            progress = scrollView.contentOffset.x / scrollW - floor(scrollView.contentOffset.x / scrollW)
            sourceIndex = Int(scrollView.contentOffset.x / scrollW)
            targetIndex = Int(scrollView.contentOffset.x / scrollW) + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }

        }
        delegate?.pageViewDidScroll(progerss: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK: - 暴露给外面的方法
extension PageView{
    func setCurrentOffset(currentIndex : Int) {
        // 1.记录需要进制执行代理方法
        isForScrollDelegate = true
        
        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
