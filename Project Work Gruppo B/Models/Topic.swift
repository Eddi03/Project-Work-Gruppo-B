//
//  Topic.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import RealmSwift


@objcMembers class Topic: Object, Codable {
    
    dynamic var title : String!
    dynamic var info: String!
    dynamic var id : String!

    var users : List<String> = List<String>()
    var albums : List<String> = List<String>()
   
    
    convenience init(title : String? = nil, info : String? = nil) {
        self.init()
        self.id = UUID().uuidString
        self.title = title
        self.info = info
       
    }
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func getTopicById(id: String)-> Topic?{
        let realm = try! Realm()
        return realm.object(ofType: Topic.self, forPrimaryKey: id)
    }
    
    func save(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self, update: true)
            }
        } catch {}
    }
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Topic] {
        return Array(realm.objects(Topic.self))
    }
    
    static func getTopicFromUser(idCurrentUser: String)-> [Topic]{
        var listaTopicOfCurrentUser : [Topic] = []
        for topic in Topic.all(){
            for var user in topic.getUsers(){
                if user == idCurrentUser {
                    listaTopicOfCurrentUser.append(topic)
                }
            }
        }
         return listaTopicOfCurrentUser
    }
    
    
    //UTENTI
    
    
        func addingUser(in realm: Realm = try! Realm(configuration: RealmUtils.config), id : String) {
            do {
                try realm.write {
                    users.append(id)
                }
            }catch {}
        }
    
        func removeUser(in realm: Realm = try! Realm(configuration: RealmUtils.config), index: Int) {
            do {
                try realm.write {
                    self.users.remove(at: index)
                }
            }catch {}
        }
    
    func getUsers() -> [String] {
        return Array(users)
    }
    
    
    
    // ALBUM
    
    func addingAlbum(in realm: Realm = try! Realm(configuration: RealmUtils.config), id : String) {
        do {
            try realm.write {
                albums.append(id)
            }
        }catch {}
    }
    
    func removeAlbum(in realm: Realm = try! Realm(configuration: RealmUtils.config), index: Int) {
        do {
            try realm.write {
                self.albums.remove(at: index)
            }
        }catch {}
    }
   
    
    func getAlbums() -> [String] {
        return Array(albums)
    }
    
//    func getAlbum(id: String) ->[String]{
//        return Array(albums)
//    }
    
}
