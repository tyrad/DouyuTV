//
//  YJNavigationController.swift
//  OperationForLandTax
//
//  Created by chen on 15/11/2.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

class YJNavigationController: UINavigationController,UINavigationControllerDelegate {
    
    var popGestureDelegate:UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popGestureDelegate = self.interactivePopGestureRecognizer?.delegate
        self.interactivePopGestureRecognizer?.delegate = nil
        self.delegate = self
        
        self.navigationBar.setBackgroundImage(UIImage.imageWithColor(RGB(254, 119, 0)), forBarMetrics: .Default)
        
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
     }
 
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count != 0 {
            //不是根视图
            //设置tabbarItem通用的返回按钮
            let button = UIButton(type: UIButtonType.Custom)
            button.setImage(UIImage(named: "btn_nav_back"), forState: .Normal)
             button.setImage(UIImage(named: "btn_nav_back_click"), forState: .Highlighted)
            button.addTarget(self, action: "popBack", forControlEvents: UIControlEvents.TouchUpInside)
            button.sizeToFit()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:button)
            //hideBottomBarWhenPushed
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    func popBack(){
        self.popViewControllerAnimated(true)
    }
    
    
    internal func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool){
        if viewController === self.viewControllers[0] { 
            self.interactivePopGestureRecognizer?.delegate = self.popGestureDelegate
        }else{
            self.interactivePopGestureRecognizer?.delegate = nil
        }
    }
    
    //UIStatusBar的颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}







