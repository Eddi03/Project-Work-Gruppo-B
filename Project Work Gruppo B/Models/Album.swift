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
    dynamic var operatorAssigned: String!
    dynamic var adminCreator: String!
    dynamic var id : String!
    dynamic var image : String?
    
    private let photos : List<Photo> = List<Photo>()
    
    convenience init(title : String? = nil, info : String? = nil, operatorAssigned : String? = nil, adminCreator : String? = nil, image : String? = nil) {
        self.init()
        self.id = UUID().uuidString
        self.title = title
        self.info = info
        self.operatorAssigned = operatorAssigned
        self.adminCreator = adminCreator
        self.image = image
    }
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func getPhotos() -> [Photo] {
        return Array(photos)
    }
    
    func addingPhoto(in realm: Realm = try! Realm(configuration: RealmUtils.config), photo : Photo) {
        do {
            try realm.write {
                photos.append(photo)
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
}
