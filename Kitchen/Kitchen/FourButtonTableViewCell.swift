//
//  FourButtonTableViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit


class FourButtonTableViewCell: UITableViewCell {

    @IBOutlet var ltButton: UIButton!
    @IBOutlet var rtButton: UIButton!
    @IBOutlet var rdButton: UIButton!
    @IBOutlet var ldButton: UIButton!
    
    
    var model: HomeModel? {
    
    didSet {
        
        let ltUrl = NSURL(string: model?.list?.firstObject?.objectForKey("one")!.objectForKey("pic_url") as! String)
        let ltData = NSData(contentsOfURL: ltUrl!)
        ltButton.setBackgroundImage(UIImage(data: ltData!), forState: .Normal)
        
        
        let ldUrl = NSURL(string: model?.list?.firstObject?.objectForKey("two")!.objectForKey("pic_url") as! String)
        let ldData = NSData(contentsOfURL: ldUrl!)
        ldButton.setBackgroundImage(UIImage(data: ldData!), forState: .Normal)
        
        
        let rtUrl = NSURL(string: model?.list?.firstObject?.objectForKey("three")!.objectForKey("pic_url") as! String)
        let rtData = NSData(contentsOfURL: rtUrl!)
        rtButton.setBackgroundImage(UIImage(data: rtData!), forState: .Normal)
        
        
        let rdUrl = NSURL(string: model?.list?.firstObject?.objectForKey("four")!.objectForKey("pic_url") as! String)
        let rdData = NSData(contentsOfURL: rdUrl!)
        rdButton.setBackgroundImage(UIImage(data: rdData!), forState: .Normal)
        
        
    }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    
    }

    
    @IBAction func ltClick(sender: AnyObject) {
        
        let content_id = model?.list?.firstObject?.objectForKey("one")!.objectForKey("content_id") as! String
        let topic_url = model?.list?.firstObject?.objectForKey("one")!.objectForKey("topic_url") as! String
        
        NSNotificationCenter.defaultCenter().postNotificationName("lt", object: nil, userInfo: ["content_id": content_id,"topic_url": topic_url])
        
    }
    @IBAction func rtClick(sender: AnyObject) {
        
        let content_id = model?.list?.firstObject?.objectForKey("three")!.objectForKey("content_id") as! String
        let topic_url = model?.list?.firstObject?.objectForKey("three")!.objectForKey("topic_url") as! String
        
        NSNotificationCenter.defaultCenter().postNotificationName("rt", object: nil, userInfo: ["content_id": content_id,"topic_url": topic_url])
        
    }
    @IBAction func rdClick(sender: AnyObject) {
        let content_id = model?.list?.firstObject?.objectForKey("four")!.objectForKey("content_id") as! String
        let topic_url = model?.list?.firstObject?.objectForKey("four")!.objectForKey("topic_url") as! String
        
        NSNotificationCenter.defaultCenter().postNotificationName("rd", object: nil, userInfo: ["content_id": content_id,"topic_url": topic_url])
        
    }
    @IBAction func ldClick(sender: AnyObject) {
        let content_id = model?.list?.firstObject?.objectForKey("two")!.objectForKey("content_id") as! String
        let topic_url = model?.list?.firstObject?.objectForKey("two")!.objectForKey("topic_url") as! String
        
        NSNotificationCenter.defaultCenter().postNotificationName("ld", object: nil, userInfo: ["content_id": content_id,"topic_url": topic_url])
        
    }

    

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
