//
//  HTTP.swift
//  DouyuTV
//
//  Created by chen on 15/11/20.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation
import Alamofire

class HTTP {
    //推荐 取得的是分组的数组
    class func getRecommentList(callBack:[RecommendSection]?->Void){
        Alamofire.request(.GET, YJRecommentURL).responseJSON { (ret) -> Void in
            var recommentList:[RecommendSection]? = nil
            switch ret.result{
            case .Success:
                recommentList = []
                if let value = ret.result.value as? NSDictionary{
                    let jsonArray = JSON(value)["data"].arrayValue
                    for section in  jsonArray{
                        let recommentSection:RecommendSection =  RecommendSection.objectWithJSON(section) as! RecommendSection
                        recommentList?.append(recommentSection)
                    }
                }
                callBack(recommentList)
            case .Failure(let error):
                DLog("failed:\(error)")
                callBack(nil)
            }
        }
    }
    
    //RecommendBanner
    class func getRecommendBannerList(callBack:[RecommendBanner]?->Void){
        Alamofire.request(.GET, YJRecommentBannerURL).responseJSON { (ret) -> Void in
            var bannerList:[RecommendBanner]? = nil
            switch ret.result {
            case .Success:
                bannerList = []
                if let value = ret.result.value as? NSDictionary{
                    let json = JSON(value)["data"].arrayValue
                    for  modelDic in json {
                        let recommendBanner:RecommendBanner = RecommendBanner.objectWithJSON(modelDic) as! RecommendBanner
                        bannerList?.append(recommendBanner)
                    }
                }
                DLog("success")
                callBack(bannerList)
            case .Failure(let error):
                DLog("failed:\(error)")
            }
        }
    }
    
    //RecommendBanner 横向滑动CollecionView的数据
    class func getRecommendCenterScrollViewMessage(callBack:[CenterSection]?->Void){
        Alamofire.request(.GET, YJRecommentCenterSectionURL).responseJSON { (ret) -> Void in
            var bannerList:[CenterSection]? = nil
            switch ret.result {
            case .Success:
                bannerList = []
                if let value = ret.result.value as? NSDictionary{
                    let json = JSON(value)["data"]["result"].arrayValue
                    for  modelDic in json {
                        let recommendBanner:CenterSection = CenterSection.objectWithJSON(modelDic) as! CenterSection
                        bannerList?.append(recommendBanner)
                        DLog("\(recommendBanner.name)")
                    }
                }
                DLog("success")
                callBack(bannerList)
            case .Failure(let error):
                DLog("failed:\(error)")
            }
        }
    }
}


//栏目2 Section 的请求
extension HTTP {
    //RecommendBanner 横向滑动CollecionView的数据
    class func getSectionGame(callBack:[SectionGame]?->Void){
        Alamofire.request(.GET, YJSectionGame).responseJSON { (ret) -> Void in
            var bannerList:[SectionGame]? = nil
            switch ret.result {
            case .Success:
                bannerList = []
                if let value = ret.result.value as? NSDictionary{
                    let json = JSON(value)["data"].arrayValue
                    for  modelDic in json {
                        let recommendBanner:SectionGame = SectionGame.objectWithJSON(modelDic) as! SectionGame
                        bannerList?.append(recommendBanner)
                    }
                }
                DLog("success")
                callBack(bannerList)
            case .Failure(let error):
                DLog("failed:\(error)")
            }
        }
    }

}

// MARK: - 直播房间列表的接口
extension HTTP{
    class func getLiveRoom(url:String, callBack:[RecommendBannerRoom]?->Void){
        DLog("url = \(url)")
        Alamofire.request(.GET, url).responseJSON { (ret) -> Void in
            var bannerList:[RecommendBannerRoom]? = nil
            switch ret.result {
            case .Success:
                bannerList = []
                if let value = ret.result.value as? NSDictionary{
                    let json = JSON(value)["data"].arrayValue
                    for  modelDic in json {
                        let recommendBanner:RecommendBannerRoom = RecommendBannerRoom.objectWithJSON(modelDic) as! RecommendBannerRoom
                        bannerList?.append(recommendBanner)
                    }
                }
                DLog("success")
                callBack(bannerList)
            case .Failure(let error):
                DLog("failed:\(error)")
            }
        }
    }


}


//补充个HttpRequest, success/failed














