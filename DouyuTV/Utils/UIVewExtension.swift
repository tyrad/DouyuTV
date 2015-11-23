//
//  UIVewExtension.swift
//  DouyuTV
//
//  Created by chen on 15/11/17.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    var width:CGFloat{
        set{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height)
        }
        get{
            return self.frame.size.width
        }
    }
    var height:CGFloat{
        set{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height)
        }
        get{
            return self.frame.size.height
        }
    }
    
    var x:CGFloat{
        set{
            self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height)
        }
        get{
            return self.frame.origin.x
        }
    }
    var y:CGFloat{
        set{
            self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height)
        }
        get{
            return self.frame.origin.y
        }
    }
}

extension UIView{
    func addBorderLayer(layerWidth:CGFloat, positon:BorderPosition ,color:UIColor){
        let borderLayer:CALayer =  CALayer()
        borderLayer.backgroundColor = color.CGColor
        if positon == .Top {
            borderLayer.frame = CGRectMake(0, 0, self.width, layerWidth)
        }else if positon == .Right{
            borderLayer.frame = CGRectMake(self.width-layerWidth, 0, layerWidth, self.height)
        }else if positon == .Bottom {
            borderLayer.frame = CGRectMake(0, self.height-layerWidth, self.width, layerWidth)
        }
        self.layer.addSublayer(borderLayer)
    }
    enum BorderPosition{
        case  Right , Top, Bottom
    }
}

extension UIView{
    func YJRootViewController()->UIViewController? {
        for var next:UIView? = self.superview; (next != nil) ;next = next!.superview{
            let nextResponder = next!.nextResponder()
            if let vc = nextResponder as? UIViewController {
                return vc
            }
        }
        return nil
    }
}
