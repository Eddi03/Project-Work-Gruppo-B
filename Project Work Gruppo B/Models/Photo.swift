//
//  Photo.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Photo: Object {
    
    dynamic var image : String?
    dynamic var info : String?
    
    dynamic var id : String!
    
    convenience init(image: String? = nil, info: String? = nil) {
        self.init()
        
        self.image = image
        self.info = info
        
        self.id = UUID().uuidString
        
        
    }
    
    func save(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self, update: true)
            }
        } catch {}
    }
    
}
