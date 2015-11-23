//
//  RecommendViewController.swift
//  DouyuTV
//
//  Created by chen on 15/11/17.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit
import Alamofire
class RecommendViewController: BaseViewController {
    
 @IBOutlet weak var recomendCollectionView: RecommendCollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadData()
    }

    override func configureViews(){
        self.first3NavigationControllerStyle()
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 
        if let id = segue.identifier {
            //点击 "更多按钮"
            if id == LiveRoomViewController.segueID {
                if let dic = sender as? [String:String] {
                    let vc =  segue.destinationViewController as! LiveRoomViewController
                    vc.cate_id  = dic["cate_id"]
                    vc.gameName = dic["title"]
                }
            }
        }
        
        
    }
    
    func loadData(){
       
        HTTP.getRecommentList { ( ret ) -> Void in
            if let data = ret {
                DLog("请求成功");
                self.recomendCollectionView.data = data
            }else{
                DLog("失败");
            }
        }
        
        HTTP.getRecommendBannerList { (ret) -> Void in
            if let data = ret {
                DLog("轮播图加载成功")
                self.recomendCollectionView.section1Data = data
            }else{
                DLog("轮播图加载失败")
            }
        }
        
        HTTP.getRecommendCenterScrollViewMessage { (ret) -> Void in
            if let data = ret {
                self.recomendCollectionView.section1CenterSectionData = data
            }else{
                DLog("轮播图加载失败")
            }
        }
        
    }
    
}











