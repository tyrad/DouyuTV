//
//  YJBannerView.swift
//  DouyuTV
//
//  Created by chen on 15/11/18.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
extension YJBannerView{
    //设定时间
    func scrollTimeInterval(time:NSTimeInterval){
        self.scrollTimerInterval = time
    }
    //给定数组
    func imageArray(array:[String]){
        self.imageGroup = array
    }
    //清除定时器
    func timerInvalidate(){
        self.timerNil()
    }
    
}

class YJBannerView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource{
    typealias BannerChangedclosure = (banner:YJBannerView,currentIndex:Int)->Void
    
    var bannerChanged:BannerChangedclosure?
    var bannerClicked:BannerChangedclosure?
    var scrollTimerInterval:NSTimeInterval = 3.5
    
    var imageGroup:[String] = []{
        didSet{
            self.someOperation()
        }
    }
    var collectionView:UICollectionView?
    var timer = GCDTimer()
    var layout:UICollectionViewFlowLayout?
    //MARK:public
    func indexChanging(closure:BannerChangedclosure?)->YJBannerView{
        self.bannerChanged = closure
        return self
    }
    func indexClick(closure:BannerChangedclosure?)->YJBannerView{
        self.bannerClicked = closure
        return self
    }
    
    //给数据
    func setImageArray(array:[String]) ->YJBannerView{
        //给数据
        self.imageGroup = array
        self.collectionView?.reloadData()
        
        
        return self
    }
    func setModelArray(models:[RecommendBanner]) ->YJBannerView{
        var imageArray:[String] = []
        for s:RecommendBanner in models{
            if let ret = YJString(s.pic_url) {
                imageArray.append(ret)
            }else{
                imageArray.append(" ")
            }
        }
        return self.setImageArray(imageArray)
    }
    
    func setUpTimer(){
        self.timer.start(scrollTimerInterval) { () -> Void in
            dispatch_async(dispatch_get_main_queue(), {
                self.timerRun()
            })
        }
    }

    
    func timerNil(){
        self.timer.stop()
    }
    
    func timerRun(){
        
        if numberOfCollections == 0 {
            return
        }
        if self.collectionView == nil {  return  }
        let currentIndex = (Int)(self.collectionView!.contentOffset.x/self.collectionView!.frame.size.width)
        
        var targetIndex = currentIndex + 1
        if targetIndex == self.numberOfCollections {
            targetIndex = (Int)((Float)(self.numberOfCollections) * 0.5)
            let indexp = NSIndexPath.init(forItem: targetIndex, inSection: 0)
            
            self.collectionView?.scrollToItemAtIndexPath(indexp,
                atScrollPosition: .None,
                animated: false)
        }
        let indexp = NSIndexPath.init(forItem: targetIndex,
            inSection: 0)
        
        self.collectionView?.scrollToItemAtIndexPath(indexp,
            atScrollPosition: .None,
            animated: true)
    }
    
    //
    var numberOfCollections:Int{
        return self.imageGroup.count * 100
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialization()
    }
    override func awakeFromNib() {
        self.initialization()
    }
    
    //初始化
    private func initialization(){
        self.layout = UICollectionViewFlowLayout()
        self.layout!.itemSize = self.frame.size
        self.layout!.minimumLineSpacing =  0
        self.layout!.scrollDirection = .Horizontal
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), collectionViewLayout: self.layout!)
        self .addSubview(self.collectionView!)
        
        
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.backgroundColor = UIColor.clearColor()
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.pagingEnabled = true
        self.collectionView?.registerClass(BannerCell.self, forCellWithReuseIdentifier: BannerCell.reuseID)
    }
    
    private func someOperation(){
        self.sendSubviewToBack(self.collectionView!)
        
        if imageGroup.count >= 1 {
            self.collectionView?.reloadData()
            //开启定时器进行轮播操作
            self.setUpTimer()
        }
    }
    
    
    //代理方法等
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let itemIndex:Int = indexPath.item % self.imageGroup.count
        //print("did select row \(indexPath.row) 第\(itemIndex)个")
        self.bannerClicked?(banner:self,currentIndex:itemIndex)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCollections
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let bannerCell:BannerCell = collectionView.dequeueReusableCellWithReuseIdentifier(BannerCell.reuseID,
            forIndexPath: indexPath) as!  BannerCell
        let itemIndex:Int = indexPath.item % self.imageGroup.count
        
        bannerCell.imageView?.image = UIImage(named:self.imageGroup[itemIndex])
        
        bannerCell.imageView?.setImageWithURL(self.imageGroup[itemIndex])
        
        return bannerCell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let itemIndex = (scrollView.contentOffset.x + scrollView.frame.size.width*0.5)/scrollView.frame.size.width
        if self.imageGroup.count == 0 {return  }
        let targetIndex:Int =  (Int)(itemIndex) % self.imageGroup.count
        //回调
        self.bannerChanged?(banner: self,
            currentIndex: targetIndex % self.imageGroup.count)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layout?.itemSize = self.frame.size
        self.collectionView?.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        if self.collectionView?.contentOffset.x == 0  && self.numberOfCollections != 0{
            let indx = NSIndexPath.init(forItem: self.numberOfCollections/2, inSection: 0)
            self.collectionView?.scrollToItemAtIndexPath(indx
                , atScrollPosition: .None, animated: false)
        }
    }
}


extension YJBannerView{
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.timerNil()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.setUpTimer()
    }
}

class BannerCell: UICollectionViewCell {
    
    static let reuseID = "BannerCellIdentifier"
    var imageView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createImageView()
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createImageView(){
        self.imageView = UIImageView.init(frame: self.bounds)
        self.imageView?.contentMode = .ScaleAspectFill
        self.addSubview(self.imageView!)
    }
    
    override func layoutSubviews() {
        if let imageV = self.imageView {
            imageV.frame = self.bounds
        }
    }
}



















