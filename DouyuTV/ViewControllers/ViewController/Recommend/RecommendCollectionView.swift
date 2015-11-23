//
//  RecommendCollectionView.swift
//  DouyuTV
//
//  Created by chen on 15/11/18.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation
import Kingfisher

class RecommendCollectionView: BaseCollectionView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    //第一组:轮播+数据单独拿出来
    var section1Data:[RecommendBanner] = []{
        didSet{
            self.reloadSections(NSIndexSet(index: 0))
        }
    }
    var section1CenterSectionData:[CenterSection] = []{
        didSet{
            self.reloadSections(NSIndexSet(index: 0))
        }
    }
    //其他分组的数据
    var data:[RecommendSection] = []{
        didSet{
            self.reloadData()
        }
    }
    
    private var layout:UICollectionViewFlowLayout{
        get{
            let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.scrollDirection = .Vertical
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 5
            return layout
        }
    }
    
    override func defaultConfig(){
        self.backgroundColor = RGB(238, 238, 238)
        self.delegate = self ;
        self.dataSource = self ;
        self.collectionViewLayout = layout
        
        self.registerNib(UINib(nibName: "RecommendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RecommendCollectionViewCell.resuseID)
    }
    
    //MARK:UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        //第一组的位置是轮播图
        if indexPath.section == 0  {
            //320*260
            return CGSizeMake(self.width, self.width/320*270)
        }
        return CGSizeMake((self.width-30)/2, (self.width-30)/2/3*2)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        
        if section == 0  {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
        return UIEdgeInsetsMake(0, 10, 10, 10)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        if section == 0  {
            return CGSizeMake(0, 0)
        }
        //第0组没有header
        return CGSizeMake(0, 30)
    }
    
//MARK: willDisplayCell didEndDisplayingCell
//    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
//        if indexPath.section == 0 {
//            DLog("willDisplayCell \(indexPath.section)");
//            //定时器
//            if let cellt =  collectionView.cellForItemAtIndexPath(indexPath) as? TopRecommendCollectionViewCell {
//                cellt.timerInit()
//            }
//        }
//    }
//    //发现的一点问题:reloadData后会调用这个.
//    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
//        DLog("didEndDisplayingCell \(indexPath.section)");
//        if indexPath.section == 0 {
//            //定时器
//            if let cellt = collectionView.cellForItemAtIndexPath(indexPath) as? TopRecommendCollectionViewCell {
//                cellt.timerDeInit()
//            }
//        }
//    }
    //MARK:collectionViewDelegate
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:TopRecommendCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(TopRecommendCollectionViewCell.resuseID,
                forIndexPath: indexPath) as! TopRecommendCollectionViewCell
            //topView
            cell.dataArrayConfigure(self.section1Data, model2: self.section1CenterSectionData)
            return cell
        }
        
        //  0 1
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(RecommendCollectionViewCell.resuseID,
            forIndexPath: indexPath) as! RecommendCollectionViewCell
        
        let section:RecommendSection = self.data[indexPath.section-1]
        cell.dataConfigure(section.roomlist[indexPath.row] as! Recommend)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        DLog("\(indexPath.row)")
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        DLog("\(self.data.count)")
        return 1 + self.data.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if section == 0 {
            return 1
        }
        let section:RecommendSection = self.data[section-1]
        return section.roomlist.count
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
            
        var reusableView:RecommendCollectionReusableView?
        if kind == UICollectionElementKindSectionHeader { //只有该类型
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader,
                withReuseIdentifier: RecommendCollectionReusableView.reuseID ,
                forIndexPath: indexPath) as? RecommendCollectionReusableView
            if indexPath.section > 0 {
                let section:RecommendSection = self.data[indexPath.section-1]
                reusableView?.titileLabel.text = YJString(section.title)
                reusableView?.cate_id = section.cate_id
            }
        }else{//不会往下走
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter,
                withReuseIdentifier: RecommendCollectionReusableView.reuseID,
                forIndexPath: indexPath) as? RecommendCollectionReusableView
        }
        return reusableView!
    }
}




class TopRecommendCollectionViewCell :BaseCollectionViewCell{
    var dataArrr:[RecommendBanner] = []{
        didSet{
            self.pageControl.numberOfPages = self.dataArrr.count
            self.bannerView.setModelArray(self.dataArrr)
            if self.dataArrr.count > 0 {
                self.setText(0)
            }
        }
    }
    //头部
    func dataArrayConfigure(model:[RecommendBanner],model2:[CenterSection]){
        self.dataArrr = model
        self.centerCollectionView.dataCet = model2
    }
    
    
    func timerInit(){
        if self.dataArrr.count  <= 1 {
            return ;
        }
        self.bannerView.setUpTimer()
    }
    func timerDeInit(){
        if self.dataArrr.count  == 0 {
            return ;
        }
        self.bannerView.timerInvalidate()
    }
    
    
    @IBOutlet weak var bannerView: YJBannerView!
    @IBOutlet weak var bannerTitle: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var messageCollectionView: UICollectionView!
    @IBOutlet weak var centerCollectionView: RecCenterCollectionView!
    
    static let resuseID = "TopRecommendCollectionViewCell"
    
    override func configuration(){
        self.messageCollectionView.backgroundColor = UIColor.whiteColor()
        self.pageControl.enabled = false
        
        //imageView
        let imageView:UIImageView = UIImageView(image: UIImage(named: "Img_default"))
        self.bannerView.collectionView?.backgroundView = imageView

        self.bannerView.indexChanging {[unowned self] (banner, currentIndex) -> Void in
            if self.pageControl.currentPage != currentIndex{
                self.pageControl.currentPage = currentIndex
                //DLog("currentIndex = \(currentIndex) ")
                //设置文字
                self.setText(currentIndex)
            }
            }.indexClick { (banner, currentIndex) -> Void in
                DLog("clicked->\(currentIndex)```")
        }
    }
    
    
    private func setText(currentIndex:Int){
        if let rb:RecommendBanner = self.dataArrr[currentIndex] {
            self.bannerTitle.text = YJString(rb.title)
        }
    }
    
    
}


class RecommendCollectionReusableView: UICollectionReusableView {
    //跳转的时候用
    var cate_id:NSString?

    static let reuseID = "RecommendCollectionReusableView"
    
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func moreMessage(sender: AnyObject) {
        print("click \(cate_id)")
        
        let dic = ["title":YJStringValue(self.titileLabel.text),
                 "cate_id":YJStringValue(self.cate_id)]
        
        self.YJRootViewController()?.performSegueWithIdentifier(LiveRoomViewController.segueID, sender: dic)
        
    }
    override func awakeFromNib() {
    }
    
    
}





