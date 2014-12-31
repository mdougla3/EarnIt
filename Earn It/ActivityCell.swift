//
//  ActivityCell.swift
//  Earn It
//
//  Created by McCay on 12/30/14.
//  Copyright (c) 2014 Change5. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activityDescriptionLabel: UILabel!
    @IBOutlet weak var activityDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
