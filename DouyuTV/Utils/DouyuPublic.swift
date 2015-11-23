//
//  DouyuPc.swift
//  DouyuTV
//
//  Created by chen on 15/11/17.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import Foundation


func DLog(items: String, function: Int32 = __LINE__,file:String = __FILE__) {
    #if DEBUG
        let className = String.fromCString(strrchr(file, Int32(("/".cStringUsingEncoding(NSUTF8StringEncoding)?.first)!))+1)!
        print("-[\(className) \(function)]: \(items)")
    #endif
}


func RGB(red:Int16,_ green:Int16, _ blue:Int16, alpha:CGFloat = 1.0)->UIColor {
    let color = UIColor.init(red:CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    return color
}


extension UIImage{
    static func imageWithColor(color:UIColor)->UIImage {
        let rect:CGRect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContextRef? = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let image:UIImage =  UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        return image
    }
}

//数据类型转换:防止诸如NSNumber传过来的问题
func YJString(aString:NSString?)->String?{
    if let str = aString {
        return "\(str)"
    }
    return nil
}

func YJStringValue(aString:NSString?)->String{
    if let str = aString {
        return "\(str)"
    }
    return ""
}

extension UIImageView{
    func setImageWithURL(urlString:NSString?,placeholder:UIImage? = UIImage(named: "Img_default")){
        if let str = urlString as? String{
            let url:NSURL? = NSURL(string: str)
            self.kf_setImageWithURL(url!, placeholderImage: placeholder)
        }else{
            let url:NSURL? = NSURL(string: "")
            self.kf_setImageWithURL(url!, placeholderImage: placeholder)
        }
    }
}



 


