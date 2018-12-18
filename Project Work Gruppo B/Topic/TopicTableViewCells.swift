//
//  AdminTableViewCell.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    static var kIdentifier = "TopicTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var titleTopic: UITextField!
    @IBOutlet weak var infoTopic: UITextField!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class AddTopicTableViewCell: UITableViewCell {
    static var kIdentifier = "AddTopicTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBOutlet weak var addButtonOutlet: UIButton! {
        didSet {
            addButtonOutlet.setTitle(R.string.localizable.kAddTopicButton(), for: .normal)
            addButtonOutlet.layer.cornerRadius = 20
            addButtonOutlet.clipsToBounds = true
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class EmptyTableViewCell: UITableViewCell {
    static var kIdentifier = "EmptyTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    @IBOutlet var message: UILabel! {
        didSet {
            message.text = R.string.localizable.kNoTopicLabel()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class AddUsersTableViewCell: UITableViewCell {
    static var kIdentifier = "AddUsersTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet var name: UITextField!
    
    @IBOutlet var checkedImage: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
