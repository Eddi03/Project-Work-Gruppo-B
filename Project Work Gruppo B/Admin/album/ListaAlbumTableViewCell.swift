//
//  ListaAlbumTableViewCell.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class ListaAlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleAlbumTextField: UITextField!
    @IBOutlet weak var infoAlbumTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
