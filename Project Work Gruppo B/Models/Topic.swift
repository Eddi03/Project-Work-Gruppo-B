//
//  Topic.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Topic: Object {
    
    dynamic var title : String!
    dynamic var info: String!
    dynamic var id : String!

    private let users : List<String> = List<String>()
    private let albums : List<String> = List<String>()
   
    
    convenience init(title : String? = nil, info : String? = nil) {
        self.init()
        self.id = UUID().uuidString
        self.title = title
        self.info = info
       
    }
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func save(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self, update: true)
            }
        } catch {}
    }
    
}
