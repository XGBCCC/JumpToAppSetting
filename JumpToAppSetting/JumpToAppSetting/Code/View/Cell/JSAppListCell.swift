//
//  JSAppListCell.swift
//  JumpToAppSetting
//
//  Created by JimBo on 2017/1/3.
//  Copyright © 2017年 JimBo. All rights reserved.
//

import UIKit

class JSAppListCell: UITableViewCell {

    static let Identifier = "JSAppListCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupWithApp(_ app:Any!){
        let displayName = REHelper.displayName(forApplication: app)
        let image = REHelper.iconImage(forApplication: app)
        textLabel?.text = displayName
        imageView?.image = image
    }
}
