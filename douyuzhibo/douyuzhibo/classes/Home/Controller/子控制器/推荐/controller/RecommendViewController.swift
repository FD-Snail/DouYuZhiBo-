//
//  RecommendViewController.swift
//  douyuzhibo
//
//  Created by wukeng on 17/1/10.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10.0
private let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2.0
private let kNormalItemH = kNormalItemW * 0.75
private let kHeaderViewH : CGFloat = 50
private let kNormalCellID = "wuk_normalCellID"
private let kprettyCellID = "wuk_prettyCellID"
private let kHeadViewID = "wuk_headViewID"


class RecommendViewController: UIViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let c : UICollectionView =  UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        c.backgroundColor = UIColor.white
        c.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        c.dataSource = self
        c.delegate = self
//        c.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        c.register(UINib(nibName: "wuk_CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        c.register(UINib(nibName: "wuk_PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kprettyCellID)
        c.register(UINib(nibName: "wuk_CollectionHeadView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        
        return c
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension RecommendViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}


// MARK: - colloctionView
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kprettyCellID, for: indexPath)
        }
        else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kNormalItemW * 4.0 / 3.0)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}




