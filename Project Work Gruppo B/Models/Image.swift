//
//  Image.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import RealmSwift

@objcMembers class Image: Object {
    
    dynamic var image : Data?
    dynamic var info : String?
    dynamic var discarded : Bool = false
    dynamic var id : String!
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(image: Data? = nil, info: String? = nil,discarded: Bool? = nil, id: String!) {
        self.init()
        self.image = image
        self.info = info
        self.discarded = discarded ?? false
        self.id = id
    }
    
    func save(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self, update: true)
            }
        } catch {}
    }
    
    static func getImageById(id: String)-> Image?{
        let realm = try! Realm()
        return realm.object(ofType: Image.self, forPrimaryKey: id)
    }
    
    static func getImageFromAlbum(idCurrentAlbum: String,discarded: Bool) ->[Image]{
        var listaImageOfCurrentAlbum : [Image] = []
        for album in Album.all(){
            if idCurrentAlbum == album.id{
                for idImage in album.getPhotos(){
                    if let image = Image.getImageById(id: idImage){
                        if image.discarded == discarded{
                        listaImageOfCurrentAlbum.append(image)
                        }
                    }
                }
            }
        }
        
        return listaImageOfCurrentAlbum
    }
    
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Image] {
        return Array(realm.objects(Image.self))
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
                realm.delete(realm.objects(Image.self))
            }
        } catch {}
    }
}
