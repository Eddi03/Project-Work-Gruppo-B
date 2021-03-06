//
//  User.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 28/11/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class User: Object {
    dynamic var name : String!
    dynamic var surname : String!
    dynamic var email : String!
    dynamic var image : String?
    dynamic var supervisor : Bool!
    dynamic var id : String!
    
    convenience init(email : String? = nil, name : String? = nil, surname : String? = nil, id : String? = nil, image : String? = nil, supervisor : Bool? = nil) {
        self.init()
        self.email = email
        self.name = name
        self.surname = surname
        self.id = id
        self.image = image
        self.supervisor = supervisor
    }
    
    func getFullName() -> String{
        var s = String(name)
        s+=" "
        s+=surname
        return s
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
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [User] {
        return Array(realm.objects(User.self))
    }
}

