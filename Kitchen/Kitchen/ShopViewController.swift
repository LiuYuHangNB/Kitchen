//
//  ShopViewController.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/12.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    var urlStr:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("/","/","传过来的Url",(urlStr))
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
