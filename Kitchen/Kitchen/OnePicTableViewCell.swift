//
//  OnePicTableViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/8.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class OnePicTableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    
    var model: HomeModel? {
        
        didSet{
            
            let ltUrl = NSURL(string: model?.list?.objectAtIndex(1).objectForKey("one")!.objectForKey("pic_url") as! String)
            
            self.imgView.sd_setImageWithURL(ltUrl, placeholderImage: nil)
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
