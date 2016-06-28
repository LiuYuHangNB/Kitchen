//
//  WebViewController.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/12.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var urlStr: String?
    var webbView: WKWebView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "粮仓商店"
    print("/","/","传过来的Url",(urlStr))

        self.webbView = WKWebView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        self.webbView!.loadRequest(NSURLRequest.init(URL: NSURL.init(string: urlStr!)!))
//        self.webbView?.UIDelegate = self
//        self.webbView?.navigationDelegate = self
        self.view.addSubview(webbView!)
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
