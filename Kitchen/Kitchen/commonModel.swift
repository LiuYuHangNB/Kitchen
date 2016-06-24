//
//  commonModel.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/17.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class commonModel: NSObject {

    var goods_id: String?
    var goods_image: String?
    var goods_name: String?
    var price: String?
    var like_count: String?
    var brand_info: NSDictionary?
/*
    "brand_info": {
    "brand_id": "315",
    "brand_name": "Money Socks",
    "brand_desc": "MoneySocks的名字灵感，来源于“Penny Farthing”。\r\nPenny Farthing，是那些在图册中时常能见到的，前轮巨大、后轮非常迷你的早期自行车雏形，也是世界上第一台被称作自行车的器械。极具特色的造型，使得早年使用它们的绅士们在骑行过程中，会不自觉的露出袜子。这份专注与偏好，深深影响了Money Socks。",
    "brand_logo": "http://imgs-qn.iliangcang.com/ware/brand/315.jpg"
    }
*/
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
