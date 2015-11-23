//
//  MyCollectionViewCell.swift
//  DouyuTV
//
//  Created by chen on 15/11/21.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit


 
class RecommendCollectionViewCell :BaseCollectionViewCell{
    static let resuseID = "RecommendCollectionViewCell"
    
    func dataConfigure(model:AnyObject){
        if let  md = model as? Recommend {
            self.data = md
        }
        if let fans =  model as? RecommendBannerRoom {
            self.data2 = fans
        }
    }
    
    
    private var data2:RecommendBannerRoom?{
        didSet{
            self.name.text = YJString(self.data2?.nickname)
            self.count.text = YJString(self.data2?.online)
            self.roomName.text = YJString(self.data2?.room_name)
            //设置图片
            
            self.imageView.setImageWithURL(self.data2?.room_src)
           
        }
    }
 
    
    private var data:Recommend?{
        didSet{
            self.name.text = YJString(self.data?.nickname)
            self.count.text = YJString(self.data?.online)
            self.roomName.text = YJString(self.data?.room_name)
            //设置图片
            self.imageView.setImageWithURL(self.data?.room_src)
          
        }
    }
    override func configuration(){
        self.backgroundColor = UIColor.whiteColor()
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var roomName: UILabel!
}

