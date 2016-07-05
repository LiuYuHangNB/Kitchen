//
//  BrandCollectionViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource{
    
    var tableView: UITableView!
    var modelArray: NSMutableArray?
    var page: NSInteger!
    var isUploading: Bool?
    var has_more: Bool?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.modelArray = NSMutableArray()
        self.page = 1
        self.isUploading = false
        self.initData()
        self.initTableView()
        
        self.upRefresh()
        self.downRefresh()
    }
    
    func initData() {
        
        SVProgressHUD.showWithStatus("数据加载中...")
        SVProgressHUD.setDefaultStyle(.Dark)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","text/html","text/css","text/plain", "application/javascript"]
        
        var url = "http://mobile.iliangcang.com/brand/brandList/?page=$&count=20&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
        
        let page = "\(self.page)"
        url = url.stringByReplacingOccurrencesOfString("$", withString: page)
        manager.GET(url, parameters: nil, progress: { (downloadProgress: NSProgress) -> Void in
            
            }, success: { (task: NSURLSessionDataTask,
                responseObject: AnyObject?) -> Void in
                
                self.has_more = (responseObject?.objectForKey("data") as! NSDictionary).objectForKey("has_more") as? Bool
                
                if self.isUploading == false {
                    
                    self.modelArray?.removeAllObjects()
                }
                
                let arr: NSArray = (responseObject?.objectForKey("data") as! NSDictionary).objectForKey("items") as! NSArray
                for dic in arr {
                    let model = BrandModel()
                    model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    
                    self.modelArray!.addObject(model)
                }
                
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
                if self.has_more == false {
                    
                    self.tableView.mj_footer.endRefreshingWithNoMoreData()
                }
                
                
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
        }

    }
    func initTableView() {
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, 0, 0), style:.Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView.backgroundColor = UIColor.blackColor()
        self.contentView.addSubview(tableView!)
        tableView?.tableFooterView = UIView()
        tableView?.separatorStyle = .None
        tableView?.registerNib(UINib.init(nibName: "BrandTableViewCell", bundle: nil), forCellReuseIdentifier: "bCell")
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.modelArray?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let model = self.modelArray![indexPath.row] as! BrandModel
        
        let cell = tableView.dequeueReusableCellWithIdentifier("bCell") as! BrandTableViewCell
        cell.selectionStyle = .None
        cell.model = model
        cell.backgroundColor = UIColor.blackColor()
        cell.accessoryType = .DisclosureIndicator
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 120
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.tableView?.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentView.frame.size.height - 64)
    }
    
    
    func downRefresh() {
        
        tableView?.mj_header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            
            self.isUploading = false
            self.page = 1
            self.tableView.reloadData()
            self.initData()
            
        })
        
    }
    func upRefresh() {
        
        tableView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            
            self.isUploading = true
            self.page = self.page! + 1
            self.initData()
            
        })
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
