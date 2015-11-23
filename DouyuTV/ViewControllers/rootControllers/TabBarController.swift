//
//  TabBarController.swift
//  DouyuTV
//
//  Created by chen on 15/11/17.
//  Copyright © 2015年 YJ_cn. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundImage = UIImage.imageWithColor(UIColor.whiteColor())
        self.tabBar.translucent = false
        
        self.setUpViewControllers()
        
    }
    
    func setUpViewControllers(){
        let title = ["推荐","栏目","直播","我的"]
        let images = ["btn_home","btn_column","btn_live","btn_user"];
        for var i = 0 ; i < title.count; i++ {
            if let tabbarItem = self.tabBar.items?[i]{
                tabbarItem.image = UIImage(named: images[i]+"_normal")?.imageWithRenderingMode(.AlwaysOriginal)
                tabbarItem.selectedImage = UIImage(named: "\(images[i])_selected")?.imageWithRenderingMode(.AlwaysOriginal)
                tabbarItem.title =  title[i]
            }
        }
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
    }
 

}
