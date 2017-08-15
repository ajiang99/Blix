//
//  FilterCustomCell.swift
//  Blix
//
//  Created by Andrew Jiang on 8/15/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class FilterCustomCell: UITableViewCell {
    @IBOutlet var selectedCell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
