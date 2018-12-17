//
//  PhotoCollectionViewCells.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 12/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class PhotoItemCell: UICollectionViewCell {
    static var kIdentifier = "PhotoCollectionViewCell"
    
    @IBOutlet var img: UIImageView!{
        didSet{
            img.contentMode = .scaleAspectFill
            img.clipsToBounds=true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = self.bounds
    }
    
    
}
class LabelItemCell: UICollectionViewCell {
    static var kIdentifier = "LabelCollectionViewCell"
    
    @IBOutlet var text: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
