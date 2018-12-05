//
//  OperatorTableViewCell.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AlbumOperatorTableViewCell: UITableViewCell {
static var kIdentifier = "AlbumOperatorCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var titleOutlet: UILabel!
    @IBOutlet var infoOutlet: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
