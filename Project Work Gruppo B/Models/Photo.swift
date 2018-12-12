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
    dynamic var dateCreated : String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    dynamic var id : String!
    convenience init(image: String? = nil, info: String? = nil, dateCreated: String? = nil, id: String!) {
        self.init()
        
        self.image = image
        self.info = info
        
        self.id = id
        
        
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
    
    static func getPhotoFromAlbum(idCurrentAlbum: String) ->[Photo]{
        var listaPhotoOfCurrentAlbum : [Photo] = []
        for album in Album.all(){
            if idCurrentAlbum == album.id{
                for idPhoto in album.getPhotos(){
                    let photo = Photo.getPhotoById(id: idPhoto)
                    listaPhotoOfCurrentAlbum.append(photo ?? Photo())
                }
            }
        }
    return listaPhotoOfCurrentAlbum
    }
    
    func delete(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {}
    }
    
    
}
