//
//  LiveRoomViewController.swift
//  DouyuTV
//
//  Created by chen on 15/11/21.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//
import MJRefresh

import UIKit
/// 直播房间列表（通用）
class LiveRoomViewController: BaseViewController {
    
    //徐传入游戏id 和 游戏名字
    //游戏类别id
    var cate_id:String?
    //游戏名字
    var gameName:String?
    
    var page:uint = 0
    
    static let segueID = "LiveRoomViewController"
    
    @IBOutlet weak var liveCollectionView: LiveCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
    override func configureViews() {
        self.navigationItem.title = self.gameName
        
        self.liveCollectionView.headerRefresh { [unowned self]() -> Void in
            self.loadData()
        }.footerRefresh { [unowned self]() -> Void in
            self.loadMoreData()
        }
        
 
            
 
        
        
    }
    
    private func loadData(){
        self.page = 0
        if let myCate_id = self.cate_id {
            HTTP.getLiveRoom(YJSectionGameDetaiList(myCate_id, page: self.page)) { [unowned self] (ret) -> Void in
                if let data = ret {
                    self.liveCollectionView.data = data
                    if data.count == 0 {
                        DLog("暂时无人直播~~~~~~~~~~~~~~~~~~~")
                    }
                }
                self.liveCollectionView.headerEndRefresh()
            }
        }else{
            DLog("cate_id类型错误")
        }
    }
    
    private func loadMoreData(){
        self.page++
        if let myCate_id = self.cate_id {
            HTTP.getLiveRoom(YJSectionGameDetaiList(myCate_id, page: self.page)) { [unowned self](ret) -> Void in
                if let data = ret {
                    self.liveCollectionView.data += data
                }
                self.liveCollectionView.headerEndRefresh()
            }
        }else{
            DLog("cate_id类型错误")
        }
    
    }
    
    deinit{
        DLog("live list deinit")
    }
    
}



extension LiveRoomViewController{
    override func viewWillAppear(animated: Bool) {
        if self.cate_id == nil {
            DLog("错误的cate_id")
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
}





