//
//  Recommend.swift
//  DouyuTV
//
//  Created by chen on 15/11/20.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation

class Recommend: NSObject {
    var cate_id:NSString?
    var game_name:NSString?
    var game_url:NSString?
    var nickname:NSString?
    var online:NSString?
    var owner_uid:NSString?
    var room_id:NSString?
    var room_name:NSString?
    var room_src:NSString?
    var show_time:NSString?
    var specific_catalog:NSString?
    var specific_status:NSString?
    var subject:NSString?
    var url:NSString?
    var vod_quality:NSString?
}


class RecommendSection:NSObject {
    var cate_id:NSString?
    var roomlist:NSArray = [] //数组存放Recommend
    var title:NSString?
    //表示roomlist存放的是Recommend对象
    override func objectClassInArray() -> [String:String]{
        return ["roomlist":"Recommend"]
    }
}


//轮播图
class RecommendBanner:NSObject{
    var id:NSString?
    var pic_url:NSString?
    var title:NSString?
    var room:RecommendBannerRoom?
}

// Recommend
// RecommendBannerRoom
class RecommendBannerRoom:NSObject{
    var cate_id:NSString?
    var fans:NSString?
    var game_name:NSString?
    var game_url:NSString?
    var nickname:NSString?
    var online:NSString?
    var owner_avatar:NSString?
    var owner_uid:NSString?
    var owner_weight:NSString?
    var room_id:NSString?
    var room_name:NSString?
    var room_src:NSString?
    var show_details:NSString?
    var show_status:NSString?
    var show_time:NSString?
    var specific_catalog:NSString?
    var specific_status:NSString?
    var url:NSString?
    var vod_quality:NSString?
}


class CenterSection:NSObject{
    var admin:NSString?
    var ctime:NSString?
    var id:NSString?
    var mobile_switch:NSString?
    var name:NSString?
    var push_android:NSString?
    var push_ios:NSString?
    var related_id:NSString?
    var sort:NSString?
    var status:NSString?
    var url:NSString?
}

















