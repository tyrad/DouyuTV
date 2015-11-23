//
//  LiveViewController.swift
//  DouyuTV
//
//  Created by chen on 15/11/17.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

class LiveViewController: BaseViewController {

    @IBOutlet weak var collectionView: LiveCollectionView!
    private var page:uint = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.first3NavigationControllerStyle()
        
        self.loadData()
        
        collectionView.headerRefresh {[unowned self] () -> Void in
            self.loadData()
        }.footerRefresh { () -> Void in
            self.loadmMoreData()
        }
        
     }
  
    func loadmMoreData(){
        self.page++
        HTTP.getLiveRoom(YJliveURL(self.page)) {[unowned self] (data) -> Void in
            if let ret = data {
                if ret.count == 0 {
                    //显示无更多数据，稍后做修改
                    self.collectionView.noMoreMessage()
                }
                self.collectionView.data += ret
            }
            self.collectionView.footerEndRefresh()
        }
    }
    
    func loadData(){
        self.page = 0
        HTTP.getLiveRoom(YJliveURL(self.page)) {[unowned self] (data) -> Void in
            if let ret = data {
                self.collectionView.data = ret
            }
            self.collectionView.headerEndRefresh()
        }
    }
      
    
}
















