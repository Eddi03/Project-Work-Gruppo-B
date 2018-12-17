//
//  Album.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//


import UIKit
import RealmSwift

@objcMembers class Album: Object, Codable {
    dynamic var title : String!
    dynamic var info: String!
    dynamic var id : String!
    dynamic var completed : Bool = false
    dynamic var creationDate : String!

    var photos : List<String> = List<String>()
    
    convenience init(title : String? = nil, info : String? = nil, completed : Bool = false) {
        self.init()
        self.id = UUID().uuidString
        self.title = title
        self.info = info
        self.completed = completed
        self.creationDate = Date().todayDate
    }
    override class func primaryKey() -> String? {
        return "id"
    }
    
    
    func changeData(in realm: Realm = try! Realm(configuration: RealmUtils.config), completed : Bool = false) {
        do {
            try realm.write {
                self.completed = completed
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
    
    func delete(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(self)
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
    
    static func deleteAll(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.delete(realm.objects(Album.self))
            }
        } catch {}
    }
    
    
    static func getAlbumById(id: String)-> Album?{
        let realm = try! Realm()
        return realm.object(ofType: Album.self, forPrimaryKey: id)
    }
    
    static func getAlbumFromTopic(idCurrentTopic: String) -> [Album]{
        
        var listaAlbumOfCurrentTopic : [Album] = []
        for topic in Topic.all(){
            if idCurrentTopic == topic.id{
                for idAlbum in topic.getAlbums(){
                    let album = Album.getAlbumById(id: idAlbum)
                    //if album?.completed == true {
                        listaAlbumOfCurrentTopic.append(album ?? Album())
                    //}
                }
            }
        }
        return listaAlbumOfCurrentTopic
    }
    
    
}
