//
//  CommonCollectionViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/17.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class CommonCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var kindLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var likeCountLabel: UILabel!
    
    var model: commonModel? {
        
        didSet{
            
            imgView.sd_setImageWithURL(NSURL(string: (model?.goods_image)!), placeholderImage: nil)
            nameLabel.text = model?.goods_name
            
            kindLabel.text = (model?.brand_info)!.objectForKey("brand_name") as? String
            priceLabel.text = "$" + (model?.price)!
            
            likeCountLabel.text = model?.like_count
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
