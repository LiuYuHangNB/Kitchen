//
//  SubjectTableViewCell.swift
//  Kitchen
//
//  Created by 刘宇航 on 16/6/24.
//  Copyright © 2016年 刘宇航. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    var model: SubjectModel? {
        
        didSet {
            
            imgView.sd_setImageWithURL(NSURL.init(string: (model?.cover_img)!), placeholderImage: UIImage.init(named: "angle-mask@3x"))
            titleLabel.text = model?.topic_name
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
