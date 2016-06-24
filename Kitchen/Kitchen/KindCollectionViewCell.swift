//
//  KindCollectionViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

typealias cellClosure = (str: String) -> Void?

class KindCollectionViewCell: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    var myClosure: cellClosure?
    var kindModelArray: NSMutableArray?
    var tableView: UITableView?
    var array: NSArray?
    var secondModelArray: NSMutableArray?
    var secondStr: String?
    
    func initClosure(closure: cellClosure) {
        
        self.myClosure = closure
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        kindModelArray = NSMutableArray()
        array = NSArray()
        self.initData()
        self.initTableView()
    }

    func initData() {
        
        SVProgressHUD.showWithStatus("数据加载中...")
        SVProgressHUD.setDefaultStyle(.Dark)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","text/html","text/css","text/plain", "application/javascript"]
        
        manager.GET("http://mobile.iliangcang.com/goods/goodsCategory?a=b&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975", parameters: nil, progress: { (downloadProgress: NSProgress) -> Void in
            
            }, success: { (task: NSURLSessionDataTask,
                responseObject: AnyObject?) -> Void in
                
                var items = NSArray()
                items = (responseObject?.objectForKey("data")?.objectForKey("items"))! as! NSArray

                for dic in items {
                let kModel = KindModel()
                kModel.isExpanded = false
                kModel.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                                        
                   self.array = (dic as! NSDictionary) .objectForKey("second")?.lastObject as? NSArray
                    
                    self.secondModelArray = NSMutableArray()
                    for dict in self.array! {
                        
                        let model = KindSecondModel()
                        model.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                        self.secondModelArray?.addObject(model)
                        
                        
                    }
                    
                 kModel.cellModels = self.secondModelArray
                self.kindModelArray?.addObject(kModel)

                }
        
                SVProgressHUD.dismiss()
                self.tableView?.reloadData()
                
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                
        }
        
    }

    func initTableView () {
        
        self.tableView = UITableView.init(frame: CGRectMake(0,0, 0, 0), style: .Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColor.clearColor()
        tableView?.layoutMargins = UIEdgeInsetsZero
        tableView?.separatorStyle = .None
        self.contentView.addSubview(self.tableView!)
        
        tableView?.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")

        tableView?.registerClass(HeadViewForTableView.classForCoder(), forHeaderFooterViewReuseIdentifier: "head")
        
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return (self.kindModelArray?.count)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let kindModel = self.kindModelArray?.objectAtIndex(section) as! KindModel
        
        if kindModel.isExpanded == true {
            
            return (kindModel.cellModels?.count)!
            
        }else {
            
            return 0
        }
        
       
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "cell")
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        cell.selectionStyle = .None
        cell.textLabel?.textColor = UIColor.lightGrayColor()
        let kind = self.kindModelArray![indexPath.section] as! KindModel
        let secondModel = kind.cellModels![indexPath.row] as! KindSecondModel
        cell.textLabel?.text = secondModel.cat_name
        cell.backgroundColor = UIColor.blackColor()
        return cell
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let head = tableView.dequeueReusableHeaderFooterViewWithIdentifier("head") as! HeadViewForTableView
        
        head.model = self.kindModelArray![section] as? KindModel
        
        head.initWithClosure { (isBool) -> Void? in
            
            if section != 0 {
                if isBool == false {
                    
            
                    
                }else if isBool == true {
                    
//                   tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.None, animated: true)
                  
                }
            }
            
            tableView.reloadSections(NSIndexSet(index: section), withRowAnimation: UITableViewRowAnimation.Fade)
            
            return nil
            
        }
       
//        print(self.kindModelArray)
        return head
        
    }
    
    func postMessage(string:Bool) ->Void {
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 200 * HEIGTH
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 40
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let kind = self.kindModelArray![indexPath.section] as! KindModel
        
        let second = kind.cellModels![indexPath.row] as! KindSecondModel
        
        let kindStr: String = "000" + kind.cat_id!
        
        if second.cat_id?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 1
        {
         
            secondStr = "000" + second.cat_id!
        }else {
            
            secondStr = "00" + second.cat_id!

        }
        
        secondStr = kindStr + secondStr!
        
        
        if self.myClosure != nil {
            
            self.myClosure!(str: secondStr!)
        }
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let sectionHeaderHeigth: CGFloat = 200 * HEIGTH
        
        if scrollView.contentOffset.y <= sectionHeaderHeigth && scrollView.contentOffset.y > 0 {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }else if scrollView.contentOffset.y >= sectionHeaderHeigth {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeigth, 0, 0, 0)
        }
        
    }
    
    override func layoutSubviews() {
        
        self.tableView?.frame = CGRectMake(0, 0, SCREENWIDTH, self.contentView.frame.size.height - 64)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
