//
//  BaseViewController.swift
//  OperationForLandTax
//
//  Created by chen on 15/11/2.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.configureViews()
    }

    func configureViews(){
        
    }
    
    //前三个的样式
    func first3NavigationControllerStyle(){
        self.navigationItem.titleView  = UIImageView(image: UIImage(named: "logo"))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.buttonItem(
            UIImage(named: "Image_scan"),
            selectedImage: UIImage(named: "Image_scan_click"),
            closure: { (_) -> Void in
                DLog("click")
        })
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.buttonItem(UIImage(named: "btn_search"), selectedImage: UIImage(named: "btn_search_clicked"), closure: { () -> Void in
            DLog("rightClick")
        })
    }
    
    //隐藏bar
    func setNavigationbarHidden(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}










