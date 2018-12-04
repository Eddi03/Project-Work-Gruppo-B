//
//  AdminTableViewCell.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AdminTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    
    @IBOutlet weak var titleAlbum: UITextField!
    
    @IBOutlet weak var descriptionAlbum: UITextField!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
