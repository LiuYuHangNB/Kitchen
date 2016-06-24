//
//  TableViewCellTwo.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/22.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit
typealias leftClosure = ()-> Void?
typealias rightClosure = ()-> Void?

class TableViewCellTwo: UITableViewCell {

   
    var leftButton: UIButton?
    var rightButton: UIButton?
    var buttonArray: NSMutableArray?
    var contentLabel: UILabel?
    
    var myLeft: leftClosure?
    var myRight: rightClosure?
    
    func initLeft(closure: leftClosure) {
        
        self.myLeft = closure
    }
    
    func initRight(closure: rightClosure) {
        self.myRight = closure
        
    }
    
    var model: ComDetailModel? {
        
        didSet{
            
//            contentLabel?.text = model?.goods_desc
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buttonArray = NSMutableArray()
        self.contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        leftButton = UIButton(type: .Custom)
        leftButton?.backgroundColor = UIColor.whiteColor()
        leftButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        leftButton?.setTitle("商品详情", forState: .Normal)
        leftButton?.addTarget(self, action: "left:", forControlEvents: .TouchUpInside)
        self.contentView.addSubview(leftButton!)
        
        rightButton = UIButton(type: .Custom)
        rightButton?.backgroundColor = UIColor.grayColor()
        rightButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        rightButton?.setTitle("购物须知", forState: .Normal)
        rightButton?.addTarget(self, action: "right:", forControlEvents: .TouchUpInside)
        self.contentView.addSubview(rightButton!)
        
        self.buttonArray?.addObject(leftButton!)
        self.buttonArray?.addObject(rightButton!)
        
        contentLabel = UILabel()
        contentLabel?.textColor = UIColor.whiteColor()
        contentLabel?.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(contentLabel!)
        contentLabel?.numberOfLines = 0
        
    }
 
    func left (left: UIButton) {
        
        if (self.myLeft != nil) {
            
            self.myLeft!()
        }
    }
    
    func right (right: UIButton) {
        
        if (self.myRight != nil) {
            
            self.myRight!()
        }
        
    }
    
    static func cellhight (content: String) -> CGFloat {
        
        let rect: CGRect = content.boundingRectWithSize(
            CGSizeMake(SCREENWIDTH - 20, 0),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName:
            UIFont.systemFontOfSize(14)],
            context: nil)
    
        return rect.height + 61
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        leftButton?.frame = CGRectMake(20, 5, (SCREENWIDTH - 40) / 2, 40)
        rightButton?.frame = CGRectMake(SCREENWIDTH / 2, 5, (SCREENWIDTH - 40) / 2, 40)
        
        contentLabel?.frame = CGRectMake(10, 60, SCREENWIDTH - 20, self.contentView.frame.size.height - 60)
    }
    
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
