 //
//  ComDetailViewController.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/21.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class ComDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var good_id: String?
    var imagesArray: NSMutableArray?
    var SDCView: SDCycleScrollView?
    var tableView: UITableView?
    var modelArray: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.imagesArray = NSMutableArray()
        self.modelArray = NSMutableArray()
        self.initData()
        
    }
    
    func initBackButton() {
        
        let back = UIButton.init(type: .System)
        back.frame = CGRectMake(10, 20, 30 * WIDTH, 25 * HEIGTH)
        back.setBackgroundImage(UIImage(named: "bac"), forState: .Normal)
        self.view.addSubview(back)
        back.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
        
        let aView = UIView.init(frame: CGRectMake(0, SCREENHEIGTH - 50 * HEIGTH, 40 * WIDTH, 50 * HEIGTH))
        aView.backgroundColor = UIColor(red: 31/255.0, green: 80/255.0, blue: 128/255.0, alpha: 1.0)
        self.view.addSubview(aView)
        
        let chatButton = UIButton.init(type: .System)
        chatButton.frame = CGRectMake(0, 0, 30, 30)
        chatButton.center = aView.center
        chatButton.setBackgroundImage(UIImage(named:"kefu"), forState: .Normal)
        chatButton.backgroundColor = UIColor(red: 31/255.0, green: 80/255.0, blue: 128/255.0, alpha: 1.0)
        self.view.addSubview(chatButton)
        chatButton.addTarget(self, action: "chat", forControlEvents: .TouchUpInside)
        
        
        let left = UIButton(type: .System)
        left.frame = CGRectMake(40 * WIDTH, SCREENHEIGTH - 50 * HEIGTH, (SCREENWIDTH - 40 * WIDTH) / 2, 50 * HEIGTH)
        left.setTitle("加入购物车", forState: .Normal)
        left.backgroundColor = UIColor(red: 31/255.0, green: 80/255.0, blue: 128/255.0, alpha: 0.8)
        left.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(left)
        
        
        let right = UIButton(type: .System)
        right.frame = CGRectMake(40 * WIDTH + (SCREENWIDTH - 40 * WIDTH) / 2, SCREENHEIGTH - 50 * HEIGTH, (SCREENWIDTH - 40 * WIDTH) / 2, 50 * HEIGTH)
        right.setTitle("立即购买", forState: .Normal)
        right.backgroundColor = UIColor(red: 31/255.0, green: 80/255.0, blue: 128/255.0, alpha: 0.5)
        right.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.view.addSubview(right)
        
        left.addTarget(self, action: "add", forControlEvents: .TouchUpInside)
        right.addTarget(self, action: "buy", forControlEvents: .TouchUpInside)

    }
    
    func chat() {
        
        
    }
    
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func initSDCView() {
        self.SDCView = SDCycleScrollView(frame: CGRectMake(0, 0, SCREENWIDTH, 280 * HEIGTH), delegate: nil, placeholderImage: nil)
        
        SDCView?.imageURLStringsGroup = NSArray(array: self.imagesArray!) as [AnyObject]
        SDCView?.infiniteLoop = false
        SDCView?.autoScroll = false
//        self.view.addSubview(self.SDCView!)
        

    }
    func initData (){
        
        var url = "http://mobile.iliangcang.com/goods/goodsDetail/?uid=1000002404&goods_id=$&app_key=iPhone&v=3.0.0&sig=97E9576F-B96F-48FD-BE0E-CD84610BC975&user_token=a0f54064e2031a1fecaca7cc9713e0e1"
        url = url.stringByReplacingOccurrencesOfString("$", withString: good_id!)
        SVProgressHUD.showWithStatus("数据加载中...")
        SVProgressHUD.setDefaultStyle(.Dark)
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = ["application/json", "text/json", "text/javascript","text/html","text/css","text/plain", "application/javascript"]
        
        manager.GET(url, parameters: nil, progress: { (downloadProgress: NSProgress) -> Void in
            
            }, success: { (task: NSURLSessionDataTask,
                responseObject: AnyObject?) -> Void in
                
                self.imagesArray = responseObject?.objectForKey("data")?.objectForKey("items")?.objectForKey("images_item") as? NSMutableArray
                
                
                let dic: NSDictionary = responseObject?.objectForKey("data")?.objectForKey("items") as! NSDictionary
                let model = ComDetailModel()
                model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
                self.modelArray?.addObject(model)
        
                
                self.initSDCView()
                self.initTableView()
                self.initBackButton()
                self.tableView?.reloadData()
                SVProgressHUD.dismiss()
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                
        }

    }
    
    
    func initTableView() {
        
        self.tableView = UITableView.init(frame: CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGTH - 50 * HEIGTH), style: .Plain)
        self.tableView?.backgroundColor = UIColor.blackColor()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableHeaderView = self.SDCView
        self.tableView?.separatorStyle = .None
        self.view.addSubview(self.tableView!)
        
        self.tableView?.registerNib(UINib(nibName: "TableViewCellOne", bundle: nil), forCellReuseIdentifier: "one")
        self.tableView?.registerClass(TableViewCellTwo.classForCoder(), forCellReuseIdentifier: "two")
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("one", forIndexPath: indexPath) as! TableViewCellOne
            cell.selectionStyle = .None
            cell.model = self.modelArray![indexPath.row] as? ComDetailModel
            cell.initMySelect({ () -> Void? in
                
                print("sel")
            })
            cell.initMyPush({ () -> Void? in
                print("push")
            })
            
            return cell
        }else {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("two", forIndexPath: indexPath) as! TableViewCellTwo
            cell.selectionStyle = .None
            cell.model = self.modelArray![0] as? ComDetailModel
            let model = self.modelArray![0] as? ComDetailModel
            cell.contentLabel?.text = model?.goods_desc
            cell.initLeft({ () -> Void? in
                
                cell.contentLabel?.text = model?.goods_desc

            })
            cell.initRight({ () -> Void? in
                cell.contentLabel?.text = model?.good_guide?.objectForKey("content") as? String
               
            })
            
            return cell
        
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let model = self.modelArray![0] as? ComDetailModel
        
        if indexPath.row == 0 {
            
            return 350
            
        }else {
            
            
            return TableViewCellTwo.cellhight((model?.goods_desc)!)
        }
    }
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.hidden = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.hidden = false
        
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
