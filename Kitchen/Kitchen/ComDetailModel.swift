//
//  ComDetailModel.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/22.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class ComDetailModel: NSObject {

    var goods_name: String?
    var goods_desc: String?
    var price: String?
    var like_count: String?
    var brand_info: NSDictionary?
    var good_guide: NSDictionary?
    
    /*
    "brand_info": {
    "brand_id": 315,
    "brand_name": "Money Socks",
    "brand_desc": "MoneySocks的名字灵感，来源于“Penny Farthing”。\r\nPenny Farthing，是那些在图册中时常能见到的，前轮巨大、后轮非常迷你的早期自行车雏形，也是世界上第一台被称作自行车的器械。极具特色的造型，使得早年使用它们的绅士们在骑行过程中，会不自觉的露出袜子。这份专注与偏好，深深影响了Money Socks。",
    "brand_logo": "http://imgs-qn.iliangcang.com/ware/brand/315.jpg"
    },
    */
    
    /*
    "good_guide": {
    "title": "购物指南",
    "content": "所有商品均为正品保证，下单后四个工作日内发货。中国大陆地区免运费，默认商家合作快递。\r\n蜡烛、液态品、手表等含电池产品无法空运，运输时间相较普通空运件会更久。\r\n如出现产品质量问题请在签收后72小时内联系客服。"
    }
    */
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
    }
    
}
