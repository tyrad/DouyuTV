//
//  RecCenterCollectionView.swift
//  DouyuTV
//
//  Created by chen on 15/11/21.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation


class RecCenterCollectionView: BaseCollectionView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var dataCet:[CenterSection] = []{
        didSet{
            self.reloadData()
        }
    }
    
    var layout:UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        //这里的self.height并不准确,最好给个明确的值或者比例
        layout.itemSize = CGSizeMake(self.width/3, (self.width/3)/5*4+4)
        layout.minimumInteritemSpacing = 20 
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10)
        return layout
    }
    
    
    override func defaultConfig() {
        self.backgroundColor = UIColor.whiteColor()
        
        self.alwaysBounceVertical = false
        self.collectionViewLayout = self.layout
        self.showsHorizontalScrollIndicator = false
        self.delegate = self;
        self.dataSource = self;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:RecCenterCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(RecCenterCollectionViewCell.reuseID, forIndexPath: indexPath) as! RecCenterCollectionViewCell
        
        let msg:CenterSection = self.dataCet[indexPath.row]
        cell.txt.text = YJString(msg.name)
        
        cell.setData(msg)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataCet.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
         DLog("click")
    }
    
}


class RecCenterCollectionViewCell: BaseCollectionViewCell {
    static let reuseID = "RecCenterCollectionViewCell"
    
    func setData(model:CenterSection){
        self.txt.text = YJString(model.name)
        self.img.setImageWithURL(model.url)
    }
    
    override func configuration() {
       self.backgroundColor = UIColor.whiteColor()
        self.img.layer.cornerRadius = 5
        self.img.layer.masksToBounds = true
    }

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txt: UILabel!
    
    
    
    
}















