//
//  TableViewCellOne.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/22.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit
typealias selectClosure = () -> Void?
typealias pushClosure = () -> Void?
class TableViewCellOne: UITableViewCell {
    @IBOutlet var brand_nameLabel: UILabel!
    @IBOutlet var goods_nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var barandLabel: UILabel!

    var mySelect: selectClosure?
    var myPush: pushClosure?
    
    @IBAction func selectsButton(sender: UIButton) {
        
        if (mySelect != nil) {
            
            self.mySelect!()
        }
    }
    
    @IBAction func coverButton(sender: UIButton) {
        if (myPush != nil) {
            
            self.myPush!()
        }
        
    }
    
    func initMySelect(closure: selectClosure) {
        
        self.mySelect = closure
    }
    
    func initMyPush(closure: pushClosure) {
        
        self.myPush = closure
    }
    var model: ComDetailModel? {
        
        didSet{
            
            brand_nameLabel.text = model?.brand_info?.objectForKey("brand_name") as? String
            goods_nameLabel.text = model?.goods_name
            priceLabel.text = "¥" + (model?.price)!
            likeCount.text = model?.like_count
            imgView?.sd_setImageWithURL(NSURL(string: (model?.brand_info?.objectForKey("brand_logo"))! as! String), placeholderImage: nil)
            barandLabel.text = "                  " + (model?.brand_info?.objectForKey("brand_name") as? String)!
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
