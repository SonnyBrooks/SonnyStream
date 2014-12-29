//
//  SSTableViewCell.swift
//  SonnyStream
//
//  Created by Andy Budziszek on 12/23/14.
//  Copyright (c) 2014 Andy Budziszek. All rights reserved.
//

import UIKit

class SSTableViewCell: UITableViewCell {

    @IBOutlet var usernameLabel: UILabel! = UILabel()
    @IBOutlet var timestampLabel: UILabel! = UILabel()
    @IBOutlet var sonRayTextView: UITextView! = UITextView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
