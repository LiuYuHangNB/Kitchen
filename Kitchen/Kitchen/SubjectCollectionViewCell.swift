//
//  SubjectCollectionViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit
typealias subjectClosure = (str: String) -> Void?

class SubjectCollectionViewCell: UICollectionViewCell,UITableViewDelegate, UITableViewDataSource {
 
    var tableView: UITableView!
    var modelArray: NSMutableArray!
    var myClosure: subjectClosure?
    var isUploading: Bool?
    var has_more: Bool?
    var page: Int!

    func initMyClosure (closure: subjectClosure) {
        
        self.myClosure = closure
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.isUploading = false
        self.has_more = true
        self.page = 1
        self.modelArray = NSMutableArray()
        self.initTableView()
        self.initData()
        
        self.downRefresh()
        self.upRefresh()
    }
    
    func initData() {
        
        SVProgressHUD.showWithStatus("数据加载中...")
        SVProgressHUD.setDefaultStyle(.Dark)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","text/html","text/css","text/plain", "application/javascript"]
        var url = "http://mobile.iliangcang.com/goods/shopSpecial/?page=$&count=5&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975"
        let page = "\(self.page)"
        url = url.stringByReplacingOccurrencesOfString("$", withString: page)
        manager.GET(url, parameters: nil, progress: { (downloadProgress: NSProgress) -> Void in
            
            }, success: { (task: NSURLSessionDataTask,
                responseObject: AnyObject?) -> Void in
                
                if self.isUploading == false {
                    
                    self.modelArray?.removeAllObjects()
                }
                
                self.has_more = (responseObject!["data"]as! NSDictionary)["has_more"] as? Bool
                
                let arr: NSArray = (responseObject?.objectForKey("data") as! NSDictionary).objectForKey("items") as! NSArray
                for dic in arr {
                    
                    let model = SubjectModel()
                        model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                    
                    self.modelArray.addObject(model)
                }
                
                SVProgressHUD.dismiss()
                self.tableView.reloadData()
                
                self.tableView?.mj_header.endRefreshing()
                self.tableView?.mj_footer.endRefreshing()
                
                if self.has_more == false {
                    
                    self.tableView?.mj_footer.endRefreshingWithNoMoreData()
                    
                }
                
                
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                
        }

    }
    
    func initTableView () {
        
        tableView = UITableView(frame: CGRectMake(0, 0, 0, 0), style: .Plain)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = UIColor.blackColor()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        self.contentView.addSubview(tableView)
        tableView.registerNib(UINib(nibName: "SubjectTableViewCell", bundle: nil), forCellReuseIdentifier: "sCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.modelArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("sCell") as! SubjectTableViewCell
        cell.backgroundColor = UIColor.blackColor()
        cell.model = self.modelArray[indexPath.row] as? SubjectModel
        cell.selectionStyle = .None
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 240
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let model = self.modelArray[indexPath.row] as! SubjectModel
        
        if (self.myClosure != nil) {
           
            self.myClosure!(str: model.topic_url!)
            
        }
        
        
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
            self.page = self.page + 1
            
            self.initData()
                
            
        })
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentView.frame.size.height - 48 - 15)
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
