//
//  BaseTableViewCell.swift
//  OperationForLandTax
//
//  Created by chen on 15/11/3.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configuration()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configuration(){
        
    }
}

extension BaseTableViewCell {
    
    func drawCellBottomLine(rect:CGRect,lineColor:UIColor,right:CGFloat,lengthL:CGFloat){
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
        CGContextFillRect(context, rect)
        CGContextSetStrokeColorWithColor(context,lineColor.CGColor);
        CGContextStrokeRect(context, CGRectMake(15, rect.size.height, rect.size.width-30, 1));
        //不加这句iOS7 显示不出效果
        self.subviews[0].backgroundColor = UIColor.clearColor()
    }
    
}
