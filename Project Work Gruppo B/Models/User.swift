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
    dynamic var Name : String!
    dynamic var Surname : String!
    dynamic var Email : String!
    dynamic var Image : String!
    dynamic var Supervisor : Bool = false
    dynamic var Id : String!
    
    
    convenience init(email : String? = nil, name : String? = nil, surname : String? = nil, id : String? = nil, image : String? = nil, supervisor : Bool? = nil) {
        self.init()
        self.Email = email
        self.Name = name
        self.Surname = surname
        self.Id = id
        self.Image = image
        self.Supervisor = supervisor ?? false
    }
    
    func getFullName() -> String{
        var s = String(Name)
        s+=" "
        s+=Surname
        return s
    }
    override class func primaryKey() -> String? {
        return "Id"
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
    static func getUser(in realm: Realm = try! Realm(configuration: RealmUtils.config), withid id: String) -> User? {
        return realm.object(ofType: User.self, forPrimaryKey: id)
    }
}

