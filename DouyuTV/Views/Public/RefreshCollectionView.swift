//
//  RefreshCollectionView.swift
//  DouyuTV
//
//  Created by chen on 15/11/21.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation
import MJRefresh


class RefreshCollectionView: BaseCollectionView{
    private var footerRefreshingClosure:(()->Void)?
    private var headerRefreshingClosure:(()->Void)?

    override func defaultConfig() {
        self.alwaysBounceVertical = true
    }
    
    func headerRefresh(header:refreshingClosure?) -> Self{
        self.headerRefreshingClosure = header
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [unowned self ]  () -> Void in
            self.headerRefreshingClosure?()
            })
        return self ;
    }
    
    func footerRefresh(footer:refreshingClosure?) -> Self{
        self.footerRefreshingClosure = footer
        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            [unowned self] () -> Void in
            self.footerRefreshingClosure?()
            })
        return self
    }
    
    func headerEndRefresh(){
        self.mj_header.endRefreshing()
    }
    func footerEndRefresh(){
        self.mj_footer.endRefreshing()
    }
    func noMoreMessage(){
        self.mj_footer.endRefreshingWithNoMoreData()
    }
    deinit{
//        self.footerRefreshingClosure = nil
//        self.headerRefreshingClosure = nil
//        DLog("deinit")
    }
}







