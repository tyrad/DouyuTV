//
//  LiveCollectionView.swift
//  DouyuTV
//
//  Created by chen on 15/11/21.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation

/// 直播房间列表（无组头）
class LiveCollectionView: RefreshCollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var data:[RecommendBannerRoom] = []{
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
            layout.itemSize =  CGSizeMake((self.width-30)/2, (self.width-30)/2/3*2)
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
            return layout
        }
    }
    
    override func defaultConfig() {
        self.backgroundColor = RGB(238, 238, 238)
        self.registerNib(UINib(nibName: "RecommendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: RecommendCollectionViewCell.resuseID)
        self.collectionViewLayout = self.layout
        self.delegate = self
        self.dataSource = self
    }
 
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(RecommendCollectionViewCell.resuseID,
            forIndexPath: indexPath) as! RecommendCollectionViewCell
        cell.dataConfigure(self.data[indexPath.row])
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        DLog("\(indexPath.row)")
    }
  
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.data.count
    }
}

 
 











