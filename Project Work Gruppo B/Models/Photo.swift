//
//  Photo.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Photo: Object, Codable {
    
    dynamic var image : String?
    dynamic var info : String?
    dynamic var dateCreated : String?
    dynamic var discarded : Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
    dynamic var id : String!
    convenience init(image: String? = nil, info: String? = nil, dateCreated: String? = nil, discarded: Bool? = nil,id: String!) {
        self.init()
        
        self.image = image
        self.info = info
        self.discarded = discarded ?? false
        
        self.id = id
        
        
    }
    func changeData(in realm: Realm = try! Realm(configuration: RealmUtils.config), discarded : Bool? = nil) {
        do {
            try realm.write {
                self.discarded = discarded ?? self.discarded
            }
        }catch {}
        
    }
    func save(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self, update: true)
            }
        } catch {}
    }
    
    static func getPhotoById(id: String)-> Photo?{
        let realm = try! Realm()
        return realm.object(ofType: Photo.self, forPrimaryKey: id)
    }
    
    static func getPhotoFromAlbum(idCurrentAlbum: String,discarded: Bool) ->[Photo]{
        var listaPhotoOfCurrentAlbum : [Photo] = []
        for album in Album.all(){
            if idCurrentAlbum == album.id{
                for idPhoto in album.getPhotos(){
                    if let photo = Photo.getPhotoById(id: idPhoto){
                        if photo.discarded == discarded{
                            listaPhotoOfCurrentAlbum.append(photo)
                        }
                    }
                }
            }
        }
    return listaPhotoOfCurrentAlbum
    }
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Photo] {
        return Array(realm.objects(Photo.self))
    }
    func delete(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {}
    }
    static func deleteAll(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(realm.objects(Photo.self))
            }
        } catch {}
    }
    
    
}
