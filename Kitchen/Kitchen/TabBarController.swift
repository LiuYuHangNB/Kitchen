//
//  TabBarController.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let home = HomeViewController()
        let homeNC = UINavigationController.init(rootViewController: home)
        home.tabBarItem.image = UIImage.init(named: "whiteHome");
        home.tabBarItem.title = "商店"
        
    
        let fair = FairViewController()
        let fairNC = UINavigationController.init(rootViewController: fair)
        fair.tabBarItem.image = UIImage.init(named: "whiteHome");
        fair.tabBarItem.title = "杂志"
        
        self.tabBar.translucent = false
        self.tabBar.tintColor = UIColor.whiteColor()
        self.tabBar.barTintColor = UIColor.blackColor()
        self.viewControllers = [homeNC,fairNC]
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
