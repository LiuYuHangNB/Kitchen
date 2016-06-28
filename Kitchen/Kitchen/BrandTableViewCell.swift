//
//  BrandTableViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/28.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    
    var model: BrandModel? {
        
        didSet {
            
            imgView.sd_setImageWithURL(NSURL.init(string: (model?.brand_logo)!), placeholderImage: nil)
            
            titleLabel.text = model?.brand_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
