//
//  User.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 28/11/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class User: Object, Codable{
    dynamic var name : String!
    dynamic var surname : String!
    dynamic var email : String!
    dynamic var image : String!
    dynamic var supervisor : Bool = false
    dynamic var id : String!
    
    dynamic var creationDate = ""
    
    convenience init(email : String? = nil, name : String? = nil, surname : String? = nil, id : String? = nil, image : String? = nil, supervisor : Bool? = nil) {
        self.init()
        self.email = email
        self.name = name
        self.surname = surname
        self.id = id
        self.image = image
        self.supervisor = supervisor ?? false
        self.creationDate = self.creationDate.todayDate

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
    static func getUserById(in realm: Realm = try! Realm(configuration: RealmUtils.config), withid id: String) -> User? {
        return realm.object(ofType: User.self, forPrimaryKey: id)
    }
    
    static func deleteAll(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(realm.objects(User.self))
            }
        } catch {}
    }
}

