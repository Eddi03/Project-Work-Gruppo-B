//
//  Album.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//


import UIKit
import RealmSwift

@objcMembers class Album: Object {
    dynamic var title : String!
    dynamic var info: String!
    dynamic var id : String!
    dynamic var completed : Bool!

    private let photos : List<String> = List<String>()
    
    convenience init(title : String? = nil, info : String? = nil, completed : Bool? = nil) {
        self.init()
        self.id = UUID().uuidString
        self.title = title
        self.info = info
        self.completed = completed
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
    
    func getPhotos() -> [String] {
        return Array(photos)
    }

    
    func addingPhoto(in realm: Realm = try! Realm(configuration: RealmUtils.config), id : String) {
        do {
            try realm.write {
                photos.append(id)
            }
        }catch {}
    }
    
    func removePhoto(in realm: Realm = try! Realm(configuration: RealmUtils.config), index: Int) {
        do {
            try realm.write {
                self.photos.remove(at: index)
            }
        }catch {}
    }
    
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Album] {
        return Array(realm.objects(Album.self))
    }
    

    
    
}
