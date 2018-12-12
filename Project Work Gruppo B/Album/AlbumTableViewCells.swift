//
//  ListaAlbumTableViewCell.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//
//
import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var info: UITextField!
    static var kIdentifier = "AlbumTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class AddAlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addButtonOutlet: UIButton!{
        didSet {
            addButtonOutlet.setTitle(R.string.localizable.kAddAlbumButton(), for: .normal)
        }
    }
    
    static var kIdentifier = "AddAlbumTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addButtonOutlet.layer.cornerRadius = 18
        addButtonOutlet.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


class EmptyListAlbumsTableViewCell: UITableViewCell {
    
    @IBOutlet var message: UILabel!
    
    static var kIdentifier = "EmptyListAlbumsTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
