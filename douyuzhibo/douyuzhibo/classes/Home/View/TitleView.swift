//
//  TitleView.swift
//  douyuzhibo
//
//  Created by wukeng on 17/1/9.
//  Copyright © 2017年 吴铿. All rights reserved.
//

import UIKit

protocol TitleViewDelegate : class  {
    func titleLableClicked(titleView : TitleView, selectIndex : Int)
}

// 滑动模块的高度
private let kScrollLineH : CGFloat = 2
// 字体颜色
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
class TitleView: UIView {
    // 接收外部的title数组
    fileprivate var titles : [String] = []
    fileprivate var currentIndex = 1000
    weak var delegate : TitleViewDelegate?
    // 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {[weak self] in
        let s = UIScrollView()
        s.showsHorizontalScrollIndicator = false
        s.bounces = false
        s.scrollsToTop = false
        return s
    }()
    fileprivate lazy var scrollLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1)
        return view
        
    }()
    // 便利构造函数
    init(frame: CGRect,titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
    }
    // 便利构造函数必须实现的方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - UI设置
extension TitleView{
    fileprivate func setUpUI(){
        isUserInteractionEnabled = true
        //添加scrollView
        scrollView.frame = bounds
        addSubview(scrollView)
        //添加labels
        setUpTitleLabels()
        //添加滑块
        setUpScrollLine()
        //设置初始化状态
        setFirstState()
    }
    //设置标题
    fileprivate func setUpTitleLabels(){
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelW : CGFloat = setLableWidth()
        for (index,title) in titles.enumerated() {
            //创建lable
            let label = UILabel(frame: CGRect(x: labelW * CGFloat(index), y: 0, width: labelW, height: labelH))
            //设置label 属性
            label.text = title
            label.tag = 1000 + index
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1)
            //添加label
            scrollView.addSubview(label)
            titleLabels.append(label)
            //添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClicked(tapGes:)))
            label.addGestureRecognizer(tap)
        }
    }
    //设置lable的宽度
    fileprivate func setLableWidth() -> CGFloat{
        let number = titles.count > 5 ? 5 : titles.count
        let labelW : CGFloat = frame.width / CGFloat(number)
        return labelW
    }
    //设置滑块
    fileprivate func setUpScrollLine(){
        scrollView.addSubview(scrollLine)
        let viewX : CGFloat = 20.0
        let viewY : CGFloat = self.frame.height - kScrollLineH
        let viewW = setLableWidth() - 2 * viewX
        scrollLine.frame = CGRect(x: viewX, y: viewY, width: viewW, height: kScrollLineH)
        let bottomLine = UIView(frame: CGRect(x: 0, y: self.frame.height - 0.5, width: self.frame.width, height: 0.5))
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
    }
    //初始化状态
    fileprivate func setFirstState(){
        let firstLabel = titleLabels[0]
        firstLabel.font = UIFont.systemFont(ofSize: 18)
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1)
    }
}

extension TitleView{
    @objc fileprivate func titleLabelClicked(tapGes : UITapGestureRecognizer){
        //获取当前的label
        guard let selectLabel : UILabel = tapGes.view as? UILabel else {
            return
        }
        // 1.如果点击的是同一个
        if selectLabel.tag == currentIndex {
            return
        }
        else{
            //获取之前的label
            let oldLabel = titleLabels[currentIndex - 1000]
            oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1)
            oldLabel.font = UIFont.systemFont(ofSize: 15)
            //选择label的设置
            selectLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1)
            selectLabel.font = UIFont.systemFont(ofSize: 18)
            //滑块的跟随移动
            let moveWidth = CGFloat(selectLabel.tag - currentIndex) * selectLabel.bounds.width
            UIView.animate(withDuration: 0.3, animations: { 
                self.scrollLine.frame.origin.x += moveWidth
            })
            //设置当前选中的标记
            currentIndex = selectLabel.tag
            //通知代理
            delegate?.titleLableClicked(titleView: self, selectIndex: currentIndex - 1000)
        }
    }
}

extension TitleView{
    func setCurrentIndex(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        print(sourceIndex,targetIndex)
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        //设置滑块
        let moveTotleX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        var moveX = moveTotleX * progress
        if sourceIndex == 0 && targetIndex == 0{
            moveX = sourceLabel.frame.width * (progress-1)
        }
        if sourceIndex == titleLabels.count - 1 && targetIndex == titleLabels.count - 1 {
            moveX = sourceLabel.frame.width * progress
        }
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX + 20
        //设置文字颜色渐变
//        let colorData = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
//        sourceLabel.textColor = UIColor(r: kSelectColor.0 + colorData.0 * progress, g: kSelectColor.1 + colorData.1 * progress, b: kSelectColor.2 + colorData.2 * progress, a: 1)
//        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorData.0, g: kNormalColor.1 + colorData.1, b: kNormalColor.2 + colorData.2, a: 1)
        
        currentIndex = targetIndex + 1000
    }
}
