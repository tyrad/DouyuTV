//
//  AppDelegate.swift
//  DouyuTV
//
//  Created by chen on 15/11/17.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.appApearance()
        
        return true
    }

    //设定tabbar的样式
    func appApearance(){
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes(
            [NSForegroundColorAttributeName:UIColor.darkGrayColor()],
            forState: UIControlState.Normal)
        item.setTitleTextAttributes(
            [NSForegroundColorAttributeName:RGB(240, 110, 48)],
            forState: UIControlState.Selected)
    }
    
    func navgationAppearance(){
        let item = UINavigationBar.appearance()
        item.translucent = false
    }
    

}

















