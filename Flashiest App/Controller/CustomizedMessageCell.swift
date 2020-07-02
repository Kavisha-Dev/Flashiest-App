//
//  CustomizedMessageCell.swift
//  Flashiest App
//
//  Created by Kavisha on 08/08/19.
//  Copyright © 2019 SoKa. All rights reserved.
//

import UIKit

class CustomizedMessageCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var senderEmailLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
