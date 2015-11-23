//
//  BaseCollectionView.swift
//  OperationForLandTax
//
//  Created by chen on 15/11/2.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

class BaseCollectionView: UICollectionView{

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.defaultConfig()
        
     
    }
    
    func defaultConfig(){
        self.pagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.bounces = true
    }
    
    
    

}
