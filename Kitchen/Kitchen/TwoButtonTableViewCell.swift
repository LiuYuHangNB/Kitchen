

//
//  TwoButtonTableViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class TwoButtonTableViewCell: UITableViewCell {

    @IBOutlet var lButton: UIButton!
    @IBOutlet var rButton: UIButton!
    
    var model: HomeModel? {
        
        didSet{
           
            let ltUrl = NSURL(string: model?.list?.lastObject?.objectForKey("one")!.objectForKey("pic_url") as! String)
            let ltData = NSData(contentsOfURL: ltUrl!)
            lButton.setBackgroundImage(UIImage(data: ltData!), forState: .Normal)
            
            let rUrl = NSURL(string: model?.list?.lastObject?.objectForKey("two")!.objectForKey("pic_url") as! String)
            let rData = NSData(contentsOfURL: rUrl!)
            rButton.setBackgroundImage(UIImage(data: rData!), forState: .Normal)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func liftClick(sender: AnyObject) {
        let content_id = model?.list?.lastObject?.objectForKey("one")!.objectForKey("content_id") as! String
        let topic_url = model?.list?.lastObject?.objectForKey("one")!.objectForKey("topic_url") as! String
        
        NSNotificationCenter.defaultCenter().postNotificationName("left", object: nil, userInfo: ["content_id": content_id,"topic_url": topic_url])
        
    }
    
    @IBAction func rightClick(sender: AnyObject) {
        
        let content_id = model?.list?.lastObject?.objectForKey("two")!.objectForKey("content_id") as! String
        let topic_url = model?.list?.lastObject?.objectForKey("two")!.objectForKey("topic_url") as! String
        
        NSNotificationCenter.defaultCenter().postNotificationName("right", object: nil, userInfo: ["content_id": content_id,"topic_url": topic_url])
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
