//
//  SDCDetailViewController.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/28.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class SDCDetailViewController: UIViewController,
UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    var urlStr: String?
    var modelArray: NSMutableArray?
    var collectionView: UICollectionView?
    var headLabel: UILabel?
    var isUploading: Bool?
    var has_more: Bool?
    var page: Int!
    var tableView: UITableView?
    var priceArray: NSMutableArray?
    var min: String?
    var max: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.priceArray = ["全部","0-200","201-500","501-1000","1001-3000","3000以上"]
        self.isUploading = false
        self.has_more = true
        self.page = 1
        self.modelArray = NSMutableArray()
        self.initNavi()
        self.initCollectionView()
        self.initHeadView()
        self.initData()
        self.downRefresh()
        self.upRefresh()
    }
    
    func initNavi() {
        
        self.view.backgroundColor = UIColor.blackColor()
        self.title = "商店"
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        self.navigationController?.navigationBar.translucent = false
        //背景颜色
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        //文字颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        //按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "che"), style: .Plain, target: self, action: "lanzi")
        
    }
    func initHeadView() {
        
        headLabel = UILabel(frame: CGRectMake(0, 0, SCREENWIDTH, 48 * HEIGTH))
        headLabel?.backgroundColor = UIColor.whiteColor()
        headLabel?.textAlignment = .Left
        headLabel?.font = UIFont.systemFontOfSize(14.0)
        headLabel?.text = "     价格筛选"
        headLabel?.textColor = UIColor.lightGrayColor()
        self.view.addSubview(self.headLabel!)
        
        let imageView = UIImageView(frame: CGRectMake(SCREENWIDTH - 50 * WIDTH, 15, 25 * WIDTH, 20 * HEIGTH))
        imageView.image = UIImage(named: "xia")
        self.view.addSubview(imageView)
        
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 0, SCREENWIDTH, 48 * HEIGTH)
        button.addTarget(self, action: "showTable:", forControlEvents: .TouchUpInside)
        button.backgroundColor = UIColor.clearColor()
        self.view.addSubview(button)
        
        self.tableView = UITableView(frame: CGRectMake(0, 48 * HEIGTH, SCREENWIDTH, 0 * HEIGTH), style: .Plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view?.addSubview(self.tableView!)
        self.tableView?.hidden = true
        tableView?.scrollEnabled = false
        tableView?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.priceArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.font = UIFont.systemFontOfSize(14.0)
        cell.textLabel?.textColor = UIColor.lightGrayColor()
        cell.textLabel?.text = self.priceArray![indexPath.row] as? String
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.headLabel?.text = "     " +  (self.priceArray![indexPath.row] as? String)!
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.tableView?.frame = CGRectMake(0, 48 * HEIGTH, SCREENWIDTH, 0 * HEIGTH)
            
        })
        self.collectionView?.mj_header.endRefreshing()
        
        if indexPath.row == 0{
            
            self.initTableData("", max: "")
            self.collectionView?.mj_header.beginRefreshing()
            
        }else if indexPath.row == 1 {
            
            self.initTableData("0", max: "200")
            self.collectionView?.mj_header.beginRefreshing()
            
        }else if indexPath.row == 2 {
            
            self.initTableData("201", max: "500")
            self.collectionView?.mj_header.beginRefreshing()
            
        }else if indexPath.row == 3 {
            
            self.initTableData("501", max: "1000")
            self.collectionView?.mj_header.beginRefreshing()
            
        }else if indexPath.row == 4 {
            
            self.initTableData("1001", max: "3000")
            self.collectionView?.mj_header.beginRefreshing()
            
        }else {
            
            self.initTableData("3000", max: "")
            self.collectionView?.mj_header.beginRefreshing()
            
        }
    }
    
    func showTable(btn: UIButton) {
        
        btn.selected = !btn.selected
        if btn.selected == true {
            
            self.tableView?.hidden = false
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.tableView?.frame = CGRectMake(0, 48 * HEIGTH, SCREENWIDTH, 240 * HEIGTH)
                
            })
            
        }else {
            
            //            self.tableView?.hidden = true
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                
                self.tableView?.frame = CGRectMake(0, 48 * HEIGTH, SCREENWIDTH, 0 * HEIGTH)
                
            })
        }
    }
    func initData() {
        
        SVProgressHUD.showWithStatus("数据加载中...")
        SVProgressHUD.setDefaultStyle(.Dark)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","text/html","text/css","text/plain", "application/javascript"]
        
        var url = "http://mobile.iliangcang.com/goods/goodsList?a=b&page=*&uid=1000002404&count=10&list_id=$&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975&user_token=a0f54064e2031a1fecaca7cc9713e0e1"
        url = url.stringByReplacingOccurrencesOfString("$", withString: urlStr!)
        let page: String = "\(self.page)"
        url = url.stringByReplacingOccurrencesOfString("*", withString: page)
        
        print(url)
        
        manager.GET(url, parameters: nil, progress: { (downloadProgress: NSProgress) -> Void in
            
            }, success: { (task: NSURLSessionDataTask,
                responseObject: AnyObject?) -> Void in
                if self.isUploading == false {
                    
                    self.modelArray?.removeAllObjects()
                }
                
                self.has_more = (responseObject!["data"]as! NSDictionary)["has_more"] as? Bool
                
                let array: NSArray = (responseObject!["data"]as! NSDictionary)["items"] as! NSArray
                
                for dic in array {
                    
                    let model = commonModel()
                    
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    
                    self.modelArray?.addObject(model)
                }
                
                SVProgressHUD.dismiss()
                self.collectionView?.reloadData()
                self.collectionView?.mj_header.endRefreshing()
                self.collectionView?.mj_footer.endRefreshing()
                if self.has_more == false {
                    
                    self.collectionView?.mj_footer.endRefreshingWithNoMoreData()
                    
                }
                print("---/",self.has_more)
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
        }
    }
    
    func initTableData(min: String,max:String) {
        
        self.min = min
        self.max = max
        SVProgressHUD.showWithStatus("数据加载中...")
        SVProgressHUD.setDefaultStyle(.Dark)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","text/html","text/css","text/plain", "application/javascript"]
        
        var url = "http://mobile.iliangcang.com/goods/goodsList?a=b&page=*&min=<&uid=1000002404&max=>&count=10&list_id=$&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975&user_token=a0f54064e2031a1fecaca7cc9713e0e1"
        url = url.stringByReplacingOccurrencesOfString("$", withString: urlStr!)
        let page: String = "\(self.page)"
        url = url.stringByReplacingOccurrencesOfString("*", withString: page)
        url = url.stringByReplacingOccurrencesOfString("<", withString: min)
        url = url.stringByReplacingOccurrencesOfString(">", withString: max)
        print(url)
        
        manager.GET(url, parameters: nil, progress: { (downloadProgress: NSProgress) -> Void in
            
            }, success: { (task: NSURLSessionDataTask,
                responseObject: AnyObject?) -> Void in
                if self.isUploading == false {
                    
                    self.modelArray?.removeAllObjects()
                }
                
                self.has_more = (responseObject!["data"]as! NSDictionary)["has_more"] as? Bool
                
                let array: NSArray = (responseObject!["data"]as! NSDictionary)["items"] as! NSArray
                
                for dic in array {
                    
                    let model = commonModel()
                    
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    
                    self.modelArray?.addObject(model)
                }
                
                SVProgressHUD.dismiss()
                self.collectionView?.reloadData()
                self.collectionView?.mj_header.endRefreshing()
                self.collectionView?.mj_footer.endRefreshing()
                
                if self.has_more == false {
                    
                    self.collectionView?.mj_footer.endRefreshingWithNoMoreData()
                    
                }
                
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
        }
    }
    
    func initCollectionView() {
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.itemSize = CGSizeMake((SCREENWIDTH - 36) / 2, 250 * HEIGTH)
        flowlayout.minimumLineSpacing = 12
        flowlayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRectMake(12, 60 * HEIGTH, SCREENWIDTH - 24, SCREENHEIGTH - 60 * HEIGTH - 64), collectionViewLayout: flowlayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        self.view.addSubview(collectionView!)
        collectionView?.registerNib(UINib(nibName: "CommonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cCell")
        
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.modelArray?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let model = self.modelArray![indexPath.item] as! commonModel
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cCell", forIndexPath: indexPath) as! CommonCollectionViewCell
        cell.model = model
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let model = self.modelArray![indexPath.item] as! commonModel
        
        let comDetail = ComDetailViewController()
        comDetail.good_id = model.goods_id
        self.navigationController?.pushViewController(comDetail, animated: true)
        
    }
    
    func downRefresh() {
        
        collectionView?.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            
            self.isUploading = false
            self.page = 1
            if self.headLabel?.text == "     价格筛选" {
                self.collectionView?.reloadData()
                self.initData()
                
            }else {
                self.collectionView?.reloadData()
                self.initTableData(self.min!, max: self.max!)
            }
        })
        
    }
    func upRefresh() {
        
        collectionView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            
            self.isUploading = true
            self.page = self.page + 1
            if self.headLabel?.text == "     价格筛选" {
                self.initData()
                
            }else {
                
                self.initTableData(self.min!, max: self.max!)
            }
        })
        
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
