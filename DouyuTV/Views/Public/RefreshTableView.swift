//
//  RefreshTableView.swift
//  OperationForLandTax
//
//  Created by chen on 15/11/2.
//  Copyright (c) 2015年 YJ_cn. All rights reserved.
//

import UIKit
import MJRefresh

typealias refreshingClosure = ()->Void


class RefreshTableView: BaseTableView {
    var footerRefreshingClosure:refreshingClosure?
    var headerRefreshingClosure:refreshingClosure?

    override func configuration(){

    }
    
    func headerRefresh(header:refreshingClosure?) -> RefreshTableView{
        self.headerRefreshingClosure = header
        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            [unowned self ]  () -> Void in
            self.headerRefreshingClosure?()
            })
        return self ;
    }
    
    func footerRefresh(footer:refreshingClosure?) -> RefreshTableView{
        self.footerRefreshingClosure = footer
        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            [unowned self] () -> Void in
            self.footerRefreshingClosure?()
            })
        return self
    }
}

/** 使用方法
view.headerRefresh { () -> Void in

}.footerRefresh { () -> Void in

}
*/
