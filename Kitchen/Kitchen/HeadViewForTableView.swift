//
//  HeadViewForTableView.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/16.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

typealias clickClosure = (isBool: Bool)-> Void?

class HeadViewForTableView: UITableViewHeaderFooterView {

    var imgView: UIImageView?
    var coverButton: UIButton?
    var myClosure: clickClosure?
    
    func initWithClosure(closure: clickClosure?){
        
        myClosure = closure
    }
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
        
        imgView = UIImageView()
        coverButton = UIButton(type: .System)
        coverButton?.backgroundColor = UIColor.clearColor()
        coverButton?.addTarget(self, action: "click", forControlEvents: .TouchUpInside)
        self.addSubview(imgView!)
        self.addSubview(coverButton!)

        
    }
    
    func click() {
        
        model?.isExpanded = !(model?.isExpanded)!
        
        let temp: Bool = (model?.isExpanded)!
        if (self.myClosure != nil) {
            
           self.myClosure!(isBool: temp)
            
        }
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        imgView?.frame = CGRectMake(0, 0, SCREENWIDTH, 200 * HEIGTH)
        coverButton?.frame = CGRectMake(0, 0, SCREENWIDTH, 200 * HEIGTH)
        
    }

    var model: KindModel? {
        
        didSet {
            
           imgView?.sd_setImageWithURL(NSURL.init(string: (model?.cover_img)!))
           
            

        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
