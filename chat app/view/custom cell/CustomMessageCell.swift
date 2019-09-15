//
//  CustomMessageCell.swift
//  chat app
//
//  Created by Chitra Hari on 15/08/19.
//  Copyright © 2019 Chitra Hari. All rights reserved.
//

import UIKit

class CustomMessageCell: UITableViewCell {

    @IBOutlet weak var messageBackground: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var messageBody: UILabel!
    @IBOutlet weak var senderUserName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
