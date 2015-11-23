//
//  BaseTableView.swift
//  OperationForLandTax
//
//  Created by chen on 15/11/2.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

class BaseTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    var data:NSArray = []
    var json :JSON {
        return JSON(self.data)
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.loadDelegate()
        self.configuration()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.loadDelegate()
        self.configuration()
    }
    
    func loadDelegate(){
        
        self.tableFooterView = UIView()
        self.tableHeaderView = UIView()
        
        self.delegate   = self
        self.dataSource = self
    }
    
    func configuration(){

    }
    
    //#MARK: tableView dataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30.0
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    
}












