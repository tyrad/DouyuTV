//
//  UIBarButtonItemExtension.swift
//  DouyuTV
//
//  Created by chen on 15/11/18.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    typealias barButtonItemClosure = ()->Void

    class ClosureWrapper {
        var closure: barButtonItemClosure?
        init(closure: (() -> Void)?) {
            self.closure = closure
        }
    }
    private struct AssociatedKeys {
        static var cn_BarButtonItemClosure = "cn_BarButtonItemClosure"
    }
    
    class var closure:barButtonItemClosure? {
        set{
        //闭包类型貌似属于Any 而不是anyObject,所以需要采用折中的办法,保存一个class
        objc_setAssociatedObject(self, &AssociatedKeys.cn_BarButtonItemClosure,  ClosureWrapper(closure: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            if let cl = objc_getAssociatedObject(self, &AssociatedKeys.cn_BarButtonItemClosure) as? ClosureWrapper {
                return cl.closure
            }
            return nil
        }
    }
    
    class func buttonItem(image:UIImage?,selectedImage:UIImage?,closure:barButtonItemClosure)
        ->UIBarButtonItem{
            let custonView = UIButton(type:.Custom)
            custonView.setImage((image),forState: .Normal);
            custonView.setImage((selectedImage), forState: .Selected)
            custonView.sizeToFit()
            custonView.addTarget(self, action: "itemClick", forControlEvents: .TouchUpInside)
            self.closure = closure
            return UIBarButtonItem(customView: custonView)
    }
    
    class func itemClick(){
        self.closure?()
    }
}

