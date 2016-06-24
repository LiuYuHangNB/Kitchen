//
//  HomeViewController.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate {
    
    var collectionView: UICollectionView!
    var buttonsArray: NSMutableArray!
    var titlesArray: NSMutableArray!
    var lineView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        
        self.initNavi()
        self.initButtons()
        self.initCollectionView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "ltClick:", name: "lt", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rtClick:", name: "rt", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rdClick:", name: "rd", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "ldClick:", name: "ld", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "left:", name: "left", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "right:", name: "right", object: nil)
    }
    
    func ltClick(noti: NSNotification) {
        
        let webVC = WebViewController()
        webVC.urlStr = noti.userInfo!["topic_url"] as? String
        
        let shopVC = ShopViewController()
        
        let url = "http://mobile.iliangcang.com/goods/goodsList?a=b&list_id=$&count=10&page=1&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
        shopVC.urlStr = url.stringByReplacingOccurrencesOfString("$", withString: (noti.userInfo!["content_id"] as? String)!)
        
        print(noti.userInfo)
        if (noti.userInfo!["topic_url"]?.length != 0) {
            
            print("fei")
        self.navigationController?.pushViewController(webVC, animated: true)
            
        }else {
            
            print("kong")
        self.navigationController?.pushViewController(shopVC, animated: true)
            
        }
        
        
    }
    func rtClick(noti: NSNotification) {
        
        let webVC = WebViewController()
        webVC.urlStr = noti.userInfo!["topic_url"] as? String
        
        let shopVC = ShopViewController()
        let url = "http://mobile.iliangcang.com/goods/goodsList?a=b&list_id=$&count=10&page=1&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
        shopVC.urlStr = url.stringByReplacingOccurrencesOfString("$", withString: (noti.userInfo!["content_id"] as? String)!)
        
        print(noti.userInfo)
        if (noti.userInfo!["topic_url"]?.length != 0) {
            
            print("fei")
            self.navigationController?.pushViewController(webVC, animated: true)
            
        }else {
            
            print("kong")
            self.navigationController?.pushViewController(shopVC, animated: true)
            
        }

    }
    func rdClick(noti: NSNotification) {
        
        let webVC = WebViewController()
        webVC.urlStr = noti.userInfo!["topic_url"] as? String
        
        let shopVC = ShopViewController()
        
        let url = "http://mobile.iliangcang.com/goods/goodsList?a=b&list_id=$&count=10&page=1&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
        shopVC.urlStr = url.stringByReplacingOccurrencesOfString("$", withString: (noti.userInfo!["content_id"] as? String)!)
        
        print(noti.userInfo)
        if (noti.userInfo!["topic_url"]?.length != 0) {
            
            print("fei")
            self.navigationController?.pushViewController(webVC, animated: true)
            
        }else {
            
            print("kong")
            self.navigationController?.pushViewController(shopVC, animated: true)
            
        }
    }
    func ldClick(noti: NSNotification) {
        
        let webVC = WebViewController()
        webVC.urlStr = noti.userInfo!["topic_url"] as? String
        
        let shopVC = ShopViewController()
        
        
        let url = "http://mobile.iliangcang.com/goods/goodsList?a=b&list_id=$&count=10&page=1&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
        shopVC.urlStr = url.stringByReplacingOccurrencesOfString("$", withString: (noti.userInfo!["content_id"] as? String)!)
        
        print(noti.userInfo)
        if (noti.userInfo!["topic_url"]?.length != 0) {
            
            print("fei")
            self.navigationController?.pushViewController(webVC, animated: true)
            
        }else {
            
            print("kong")
            self.navigationController?.pushViewController(shopVC, animated: true)
            
        }

    }
    func left(noti: NSNotification) {
        
        let webVC = WebViewController()
        webVC.urlStr = noti.userInfo!["topic_url"] as? String
        
        let shopVC = ShopViewController()
        
        
        let url = "http://mobile.iliangcang.com/goods/goodsList?a=b&list_id=$&count=10&page=1&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
        shopVC.urlStr = url.stringByReplacingOccurrencesOfString("$", withString: (noti.userInfo!["content_id"] as? String)!)
        
        print(noti.userInfo)
        if (noti.userInfo!["topic_url"]?.length != 0) {
            
            print("fei")
            self.navigationController?.pushViewController(webVC, animated: true)
            
        }else {
            
            print("kong")
            self.navigationController?.pushViewController(shopVC, animated: true)
            
        }

       
    }
    func right(noti: NSNotification) {
        
        let webVC = WebViewController()
        webVC.urlStr = noti.userInfo!["topic_url"] as? String
        
        let shopVC = ShopViewController()
        
        
        let url = "http://mobile.iliangcang.com/goods/goodsList?a=b&list_id=$&count=10&page=1&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
        shopVC.urlStr = url.stringByReplacingOccurrencesOfString("$", withString: (noti.userInfo!["content_id"] as? String)!)
        
        print(noti.userInfo)
        if (noti.userInfo!["topic_url"]?.length != 0) {
            
            print("fei")
            self.navigationController?.pushViewController(webVC, animated: true)
            
        }else {
            
            print("kong")
            self.navigationController?.pushViewController(shopVC, animated: true)
            
        }

    }
    
    func initNavi() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationController?.navigationBar.translucent = false
        //背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        //文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "search"), style: .Plain, target: self, action: "add")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "che"), style: .Plain, target: self, action: "lanzi")
        self.navigationItem.title = "商店"
    }
    func add() {
        
        
    }
    func lanzi() {
        
        
    }
    
    func initButtons() {
        
        buttonsArray = NSMutableArray()
        titlesArray = ["分类","品牌","首页","专题","品牌"]
        
        for var i = 0;i<titlesArray.count;i++ {
            
            let button = UIButton.init(type: .System)
            button.frame = CGRectMake(SCREENWIDTH * CGFloat (i) / 5.0, 0, SCREENWIDTH / 5.0, 40 * HEIGTH)
            button.tag = i
            button.backgroundColor = UIColor.blackColor()
            button.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            if i == 2 {
                
            button.titleLabel?.font = UIFont.systemFontOfSize(16.0 * WIDTH)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
                
            }
            button.titleLabel?.font = UIFont.systemFontOfSize(15.0 * WIDTH)
            button.setTitle(titlesArray[i] as? String, forState: .Normal)
            button.addTarget(self, action: "click:", forControlEvents: .TouchUpInside)
            self.view.addSubview(button)
            buttonsArray.addObject(button)
            
        }
        lineView = UIView.init(frame: CGRectMake(15 * WIDTH + (SCREENWIDTH / 5.0) * 2, 38 * HEIGTH, SCREENWIDTH / 5.0 - 30 * WIDTH, 2 * HEIGTH))
        lineView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(lineView)
        
    }
    func click (btn: UIButton) {
        
        for btt in buttonsArray {
            
            btt.titleLabel?!.font = UIFont.systemFontOfSize(15)
            btt.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        }
        
        btn.titleLabel?.font = UIFont.systemFontOfSize(16 * WIDTH)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.collectionView.scrollToItemAtIndexPath(NSIndexPath.init(forItem: btn.tag, inSection: 0), atScrollPosition: .None, animated: true)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.lineView.frame = CGRectMake(15 * WIDTH + (UIScreen.mainScreen().bounds.width / 5.0) * CGFloat (btn.tag), 38 * HEIGTH, UIScreen.mainScreen().bounds.width / 5.0 - 30 * WIDTH, 2)
            
            }) {(Bool) -> Void in
                
            }
    }
    
    func initCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 88 * HEIGTH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView.init(frame: CGRectMake(0, 40 * HEIGTH, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 88 * HEIGTH), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.pagingEnabled = true
        collectionView.scrollToItemAtIndexPath(NSIndexPath.init(forRow: 2, inSection: 0), atScrollPosition: .None, animated: true)
        self.view.addSubview(collectionView)
        collectionView.registerClass(HomeCollectionViewCell.classForKeyedArchiver(), forCellWithReuseIdentifier: "hCell")
        collectionView.registerClass(KindCollectionViewCell.classForKeyedArchiver(), forCellWithReuseIdentifier: "kCell")
        collectionView.registerClass(BrandCollectionViewCell.classForKeyedArchiver(), forCellWithReuseIdentifier: "bCell")
        collectionView.registerClass(SubjectCollectionViewCell.classForKeyedArchiver(), forCellWithReuseIdentifier: "sCell")
        collectionView.registerClass(GiftCollectionViewCell.classForKeyedArchiver(), forCellWithReuseIdentifier: "gCell")
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("kCell", forIndexPath: indexPath) as! KindCollectionViewCell
            
            weak var weakSelf = self
            cell.initClosure({ (str) -> Void? in
                
//                let url = "http://mobile.iliangcang.com/goods/goodsShare?a=b&page=1&count=10&coverId=1&cat_code=$&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
                
                let common = CommonViewController()
//                common.urlStr = url.stringByReplacingOccurrencesOfString("$", withString: str)
                common.urlStr = str
                common.hidesBottomBarWhenPushed = true
                weakSelf!.navigationController?.pushViewController(common, animated: true)
                return nil
             })
            
            return cell
            
        }else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("bCell", forIndexPath: indexPath) as! BrandCollectionViewCell
            return cell
        }else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("hCell", forIndexPath: indexPath) as! HomeCollectionViewCell
            cell.myClosure = { (content_id: String) -> Void in
                
                let shopVC = ShopViewController()
                let url = "http://mobile.iliangcang.com/goods/goodsList?a=b&list_id=$&count=10&page=1&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
                shopVC.urlStr = url.stringByReplacingOccurrencesOfString("$", withString: content_id)
                self.navigationController?.pushViewController(shopVC, animated: true)
            }
            return cell
        }else if indexPath.item == 3 {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("sCell", forIndexPath: indexPath) as! SubjectCollectionViewCell
            
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("gCell", forIndexPath: indexPath) as! GiftCollectionViewCell
            
            return cell
            
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        for btt in buttonsArray {
            
            btt.titleLabel?!.font = UIFont.systemFontOfSize(15)
            btt.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        }
        
        
        
        UIView.animateWithDuration(0.3) { () -> Void in
            
        self.lineView.frame = CGRectMake(15 * WIDTH + (UIScreen.mainScreen().bounds.width / 5.0) * CGFloat (self.collectionView.contentOffset.x / (UIScreen.mainScreen().bounds.width)), 38 * HEIGTH, UIScreen.mainScreen().bounds.width / 5.0 - 30 * WIDTH, 2)
        }
        
        let btn = buttonsArray.objectAtIndex(Int(self.collectionView.contentOffset.x / UIScreen.mainScreen().bounds.width))
        
        btn.titleLabel?!.font = UIFont.systemFontOfSize(16 * WIDTH)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
    
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "lt", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "rt", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "rd", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ld", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "left", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "right", object: nil)
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
