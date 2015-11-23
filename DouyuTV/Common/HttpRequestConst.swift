//
//  HttpRequestConst.swift
//  DouyuTV
//
//  Created by chen on 15/11/20.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation


let baseURL = "http://www.douyutv.com"

let YJRecommentURL = "\(baseURL)/api/v1/channel?aid=ios"

let YJRecommentBannerURL = "\(baseURL)/api/v1/slide/6?aid=ios"

let YJRecommentCenterSectionURL = "\(baseURL)/api/v1/getCyclePicture?aid=ios"

//栏目
let YJSectionGame = "\(baseURL)/api/v1/game"


//直播  返回item为 RecommendBannerRoom
func YJliveURL(page:uint, limit:uint = 20) ->String {
    let offSet = page * limit
    return  "\(baseURL)/api/v1/live?&client_sys=ios&limit=\(limit)&offset=\(offSet)&time=\((Int64)(NSDate().timeIntervalSince1970))"
}

//房间列表 房间id可能为数字或者字符串
func YJSectionGameDetaiList(id:String,page:uint,limit:uint = 20)->String{
    let offSet = page * limit
    return "\(baseURL)/api/v1/live/\(id)?aid=ios&client_sys=ios&limit=\(limit)&offset=\(offSet)&time=\((Int64)(NSDate().timeIntervalSince1970))"
}

//抓下登陆接口看看


//返回用户自己的信息 肯定和token相关的
//http://www.douyutv.com/api/v1/my_info?aid=ios&auth=7f4156746fbd6910c5a310acc4378f2f&client_sys=ios&time=1448119200&token=ff32c04fa0d719fd


//http://www.douyutv.com/api/v1/follow/check/339715?aid=ios&auth=f29af877cc4479655dd638cf12a2f4a0&client_sys=ios&time=1448119200&token=ff32c04fa0d719fd  这个没看懂。 返回的是 {"error":0,"data":0}

//返回id和对应的图片
//http://www.douyutv.com/api/v1/gift_effects?aid=ios&auth=b0b42bafa02c0cb5ae8213487e390fe2&client_sys=ios&time=1448119200




//这个接口有有效时间的 可以获得礼物/端口等  RMTP的信息
//get http://www.douyutv.com/api/v1/room/339715?aid=ios&auth=60e1dae565621124f10b0e1cd8758324&client_sys=ios&time=1448119200
//有有效时间  http://www.douyutv.com/api/v1/room/339715?aid=ios&auth=60e1dae565621124f10b0e1cd8758324&client_sys=ios&time=1448119200
/**
{
"data" : {
"black" : [],
"cate_id" : "3",
"cdns" : [
"ws",
"ws2",
"dl"
],
"fans" : "104012",
"game_name" : "DOTA2",
"game_url" : "/directory/game/DOTA2",
"gift" : [
{
"cimg" : "http://staticlive.douyutv.com/upload/dygift/7dce6b2170eebecf85596b47370217ce.gif",
"desc" : "赠送网站广播并派送出神秘宝箱",
"gx" : 5000,
"himg" : "http://staticlive.douyutv.com/upload/dygift/7f0643700d331aca31a6f6ea255e323e.gif",
"id" : "59",
"intro" : "我们的征途是星辰大海",
"mimg" : "http://staticlive.douyutv.com/upload/dygift/ab957377200959761121a3791a54b9b7.png",
"name" : "火箭",
"pc" : "50000",
"pimg" : "http://staticlive.douyutv.com/upload/dygift/447b61f6c0d6890d4490a90d0bdbf8bc.png",
"type" : "2"
},
{
"cimg" : "http://staticlive.douyutv.com/upload/dygift/9be0788c194d8a3a6f002319b7971dc0.gif",
"desc" : "赠送房间广播",
"gx" : 1000,
"himg" : "http://staticlive.douyutv.com/upload/dygift/8e9112823c19cecd7e27e524814d9470.gif",
"id" : "54",
"intro" : "主播带我飞",
"mimg" : "http://staticlive.douyutv.com/upload/dygift/5c3792f1c01c992b6836b06acc5abb5f.png",
"name" : "飞机",
"pc" : "10000",
"pimg" : "http://staticlive.douyutv.com/upload/dygift/13a983e2f18e5c2294d91273d9a49705.png",
"type" : "2"
},
{
"cimg" : "http://staticlive.douyutv.com/upload/dygift/824221e62370b373085838718f256858.gif",
"desc" : "",
"gx" : 60,
"himg" : "http://staticlive.douyutv.com/upload/dygift/f3956f7b059a6aca4d24c7436ab4e34e.gif",
"id" : "52",
"intro" : "主播这么6，你麻麻知道吗",
"mimg" : "http://staticlive.douyutv.com/upload/dygift/ab1957335f53864e90941efa6743ddb0.png",
"name" : "666",
"pc" : "600",
"pimg" : "http://staticlive.douyutv.com/upload/dygift/8cc64c797cbd6f0e0182ea5b3b7ef181.png",
"type" : "2"
},
{
"cimg" : "http://staticlive.douyutv.com/upload/dygift/8dcd680f30b229a7992fd19ec85d2d82.gif",
"desc" : "",
"gx" : 1,
"himg" : "http://staticlive.douyutv.com/upload/dygift/1e50bcda9268706cfae4bd8e9b96e4db.gif",
"id" : "57",
"intro" : "赞一个",
"mimg" : "http://staticlive.douyutv.com/upload/dygift/d39438eec2c36889561367dc6ec63efe.png",
"name" : "赞",
"pc" : "10",
"pimg" : "http://staticlive.douyutv.com/upload/dygift/2c003965e786422cd4816c14a8b0875b.png",
"type" : "2"
},
{
"cimg" : "http://staticlive.douyutv.com/upload/dygift/2a5c2c6de6e8e18483bde772cf28ca04.gif",
"desc" : "",
"gx" : 5.2,
"himg" : "http://staticlive.douyutv.com/upload/dygift/b2d45ef42b523bc0edad465b9ff33ed2.gif",
"id" : "53",
"intro" : "我爱你",
"mimg" : "http://staticlive.douyutv.com/upload/dygift/f241ebd1bd98770f4d3bc36c0bfe1b7d.png",
"name" : "520",
"pc" : "520",
"pimg" : "http://staticlive.douyutv.com/upload/dygift/0dc60e11063a7dd81b9f2bb213d0cfeb.png",
"type" : "1"
},
{
"cimg" : "http://staticlive.douyutv.com/upload/dygift/424f745bfb8bff7dcd4422e738562f6a.jpg",
"desc" : "",
"gx" : 1,
"himg" : "http://staticlive.douyutv.com/upload/dygift/a7cb18b2a449c360a9c9bec6af8b0575.png",
"id" : "50",
"intro" : "绝佳的增重美食",
"mimg" : "http://staticlive.douyutv.com/upload/dygift/fd8bbe3967cf49cddbe9f3ea9378e36f.png",
"name" : "100鱼丸",
"pc" : "100",
"pimg" : "http://staticlive.douyutv.com/upload/dygift/4efca3a88376d52011c009e83d1797d2.png",
"type" : "1"
}
],
"hls_url" : "http://hls1a.douyutv.com/live/339715r3J0Lsv77g/playlist.m3u8?wsSecret=8394de72e62fde1cdfe8339c2bd80d9b&wsTime=1448119243",
"nickname" : "单车比DC讲道理",
"online" : 250845,
"owner_avatar" : "http://uc.douyutv.com/avatar.php?uid=24166828&size=big",
"owner_uid" : "24166828",
"owner_weight" : "12.78t",
"room_dm_delay" : 30,
"room_id" : "339715",
"room_name" : "单车DC解说【秋季赛】超清不卡",
"room_src" : "http://staticlive.douyutv.com/upload/web_pic/5/339715_1511212306_thumb.jpg",
"rtmp_cdn" : "ws",
"rtmp_live" : "339715r3J0Lsv77g.flv?wsSecret=653902de8b4922b0f12186cedcb040a7&wsTime=1448119243",
"rtmp_multi_bitrate" : {
"middle" : "339715r3J0Lsv77g_550.flv?wsSecret=1c274f43e4878c3102e1b83aff668430&wsTime=1448119243",
"middle2" : "339715r3J0Lsv77g_900.flv?wsSecret=0a4afbeccfb942bedda805d40373b12e&wsTime=1448119243"
},
"rtmp_url" : "http://hdl1a.douyutv.com/live",
"servers" : [
{
"ip" : "119.90.49.107",
"port" : "8032"
},
{
"ip" : "119.90.49.92",
"port" : "8059"
},
{
"ip" : "119.90.49.93",
"port" : "8064"
},
{
"ip" : "119.90.49.93",
"port" : "8062"
},
{
"ip" : "119.90.49.101",
"port" : "8002"
},
{
"ip" : "119.90.49.102",
"port" : "8010"
},
{
"ip" : "119.90.49.107",
"port" : "8031"
},
{
"ip" : "119.90.49.110",
"port" : "8048"
},
{
"ip" : "119.90.49.105",
"port" : "8023"
},
{
"ip" : "119.90.49.103",
"port" : "8012"
}
],
"show_details" : "",
"show_status" : "1",
"show_time" : "1448098172",
"specific_catalog" : "dcboys",
"specific_status" : "1",
"url" : "/dcboys",
"use_p2p" : "0",
"vod_quality" : "0"
},
"error" : 0
}
*/



//测试
//http://www.douyutv.com/api/v1/live/1?aid=ios&auth=f307141e210a9883afe328fb9a46635a&client_sys=ios&limit=20&offset=0&time=1448239320


//这样也是有数据的
//http://www.douyutv.com/api/v1/live/1?aid=ios&client_sys=ios&limit=20&offset=0




//直播间详情
//http://www.douyutv.com/api/v1/room/93912?aid=ios&auth=b411946b57c05ab3067ea312eb18be74&client_sys=ios&time=1448239440


//直播间详情
//http://www.douyutv.com/api/v1/room/93912?aid=ios&client_sys=ios&time=1448239440




//3defb7e8437388e3299bd5080baf2790


//  8b105d80c2333e99

//http://www.douyutv.com/api/v1/live/1?aid=ios&auth=3defb7e8437388e3299bd5080baf2790&client_sys=ios&limit=20&offset=0&time=1448239980



//http://www.douyutv.com/api/v1/room/93912?aid=ios&auth=fdd83ffb7e2d400ebbd387a5069b332b&client_sys=ios&time=1448240040









