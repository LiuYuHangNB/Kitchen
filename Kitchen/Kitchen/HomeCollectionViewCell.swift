
//
//  HomeCollectionViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit
typealias OnePicClosure = (content_id: String)->Void
typealias SDCClosure = (slide_id: String,content_type: String)->Void

class HomeCollectionViewCell: UICollectionViewCell,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var MySDCClosure: SDCClosure?
    var SDCArray: NSMutableArray!
    var SDCView: SDCycleScrollView!
    var tableView: UITableView!
    var modelArray: NSMutableArray!
    var myClosure: OnePicClosure?
    var content_id: String?
    var toppic_url: String?
    var idArray: NSMutableArray!
    var typeArray: NSMutableArray!
    func initSDCClosure(closure: SDCClosure) {
        
        self.MySDCClosure = closure
    }
    
    func initMyClosure(closure: OnePicClosure) {
        
        self.myClosure = closure
    }
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.idArray = NSMutableArray()
        self.typeArray = NSMutableArray()
        self.initSDCData()

    }
    
    func initSDCData() {
    
        SVProgressHUD.showWithStatus("数据加载中...")
        SVProgressHUD.setDefaultStyle(.Dark)
        SDCArray = NSMutableArray()
        modelArray = NSMutableArray()
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","text/html","text/css","text/plain", "application/javascript"]
        
        manager.GET("http://mobile.iliangcang.com/goods/shopHome?a=b&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975", parameters: nil, progress: { (downloadProgress: NSProgress) -> Void in
            
            }, success: { (task: NSURLSessionDataTask,
                responseObject: AnyObject?) -> Void in
                
                var array = NSArray()
                array = responseObject!["data"]!!["items"]!!["slide"] as! NSArray
                for dic in array {
                    
                    self.SDCArray.addObject(dic["pic_url"]as! String)
                    
                    self.idArray.addObject(dic["content_id"]as! String)
                    self.typeArray.addObject(dic["topic_url"]as! String)
                }
                
                var dict = NSDictionary()
                dict = responseObject!["data"]!!["items"] as! NSDictionary
                self.content_id = (((dict.objectForKey("list") as! NSArray).objectAtIndex(1) as! NSDictionary).objectForKey("one") as! NSDictionary).objectForKey("content_id") as? String
                
                self.toppic_url = (((dict.objectForKey("list") as! NSArray).objectAtIndex(1) as! NSDictionary).objectForKey("one") as! NSDictionary).objectForKey("toppic_url") as? String
                
                
                    let model = HomeModel()
                    model.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                    self.modelArray.addObject(model)
               
                self.initTabelView()

                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                
        }

    }
    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        
        if MySDCClosure != nil {
            
            self.MySDCClosure!(slide_id: self.idArray[index] as! String, content_type: (self.typeArray[index] as! String))
        }
        
    }

    
    func initTabelView() {
        
        tableView = UITableView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 152 * HEIGTH), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        self.contentView.addSubview(tableView)
        tableView.registerNib(UINib.init(nibName: "FourButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "fbCell")
        
        tableView.registerNib(UINib.init(nibName: "OnePicTableViewCell", bundle: nil), forCellReuseIdentifier: "opCell")
        
        tableView.registerNib(UINib.init(nibName: "TwoButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "tbCell")
        
        self.SDCView = SDCycleScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 220 * HEIGTH), delegate: self, placeholderImage: nil)
        self.SDCView.imageURLStringsGroup = NSArray.init(array: self.SDCArray) as [AnyObject]
        self.tableView.tableHeaderView = self.SDCView

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("fbCell") as! FourButtonTableViewCell
            cell.model = self.modelArray.objectAtIndex(0) as? HomeModel
            
            return cell
            
        }else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("opCell") as! OnePicTableViewCell
            cell.model = self.modelArray.objectAtIndex(0) as? HomeModel
            
            return cell
            
        }else {
            let cell = tableView.dequeueReusableCellWithIdentifier("tbCell") as! TwoButtonTableViewCell
            cell.model = self.modelArray.objectAtIndex(0) as? HomeModel
            return cell
        }
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            
            return 420 * HEIGTH
            
        }else if indexPath.row == 1 {
            
            return 220 * HEIGTH
            
        }else {
            
            let height = UIScreen.mainScreen().bounds.width / 2
            return height
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 1 {
            
        print(self.content_id)
        print(self.toppic_url)
            
            if(myClosure != nil) {
                
                myClosure!(content_id: self.content_id!)
            }
            
        }
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
