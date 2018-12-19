//
//  GenericSettings.swift
//  Heldev
//
//  Created by stefano vecchiati on 10/11/2018.
//  Copyright © 2018 com.stefanovecchiati. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class GenericSettings: Object, Codable {

    dynamic var id: String = "settings"
    
    dynamic var heightElementStandardConstraint : CGFloat = 50
    dynamic var heightElementOldIphonesConstraint : CGFloat = 40
    
    dynamic var customPrimaryColor : String = "007AFF"
    
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
    
    static func getObject(in realm: Realm = try! Realm(configuration: RealmUtils.config), withId id : String = "settings") -> GenericSettings? {
        if realm.object(ofType: GenericSettings.self, forPrimaryKey: id) == nil {
            GenericSettings().save()
        }
        return realm.object(ofType: GenericSettings.self, forPrimaryKey: id)
    }
    
}
