//
//  Message.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 18/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import Foundation
import MessageKit
import RealmSwift

internal struct Msg: MessageType {
    
    var messageId: String
    var sender: Sender
    var sentDate: Date
    var kind: MessageKind

    private init(kind: MessageKind, sender: Sender, messageId: String, date: Date) {
        self.kind = kind
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
    }
    init(custom: Any?, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .custom(custom), sender: sender, messageId: messageId, date: date)
    }
    init(text: String, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .text(text), sender: sender, messageId: messageId, date: date)
    }
    init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .attributedText(attributedText), sender: sender, messageId: messageId, date: date)
    }
    //    init(image: UIImage, sender: Sender, messageId: String, date: Date) {
    //        let mediaItem = ImageMediaItem(image: image)
    //        self.init(kind: .photo(mediaItem), sender: sender, messageId: messageId, date: date)
    //    }
    //
    //    init(thumbnail: UIImage, sender: Sender, messageId: String, date: Date) {
    //        let mediaItem = ImageMediaItem(image: thumbnail)
    //        self.init(kind: .video(mediaItem), sender: sender, messageId: messageId, date: date)
    //    }
    //
    //    init(location: CLLocation, sender: Sender, messageId: String, date: Date) {
    //        let locationItem = CoordinateItem(location: location)
    //        self.init(kind: .location(locationItem), sender: sender, messageId: messageId, date: date)
    //    }
    init(emoji: String, sender: Sender, messageId: String, date: Date) {
        self.init(kind: .emoji(emoji), sender: sender, messageId: messageId, date: date)
    }
}

@objcMembers class Message: Object, Codable {
    
    dynamic var id: String!
    dynamic var idAlbum : String!
    dynamic var senderName: String!
    dynamic var senderId: String!
    dynamic var sentDate: Date!
    dynamic var messageText: String!
    
    override class func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: String,idAlbum: String, messageText: String, senderName: String, senderId: String, sentDate: Date) {
        self.init()
        self.id = id
        self.idAlbum = idAlbum
        self.senderName = senderName
        self.senderId = senderId
        self.sentDate = sentDate
        self.messageText = messageText
    }
    func save(in realm: Realm = try! Realm(configuration: RealmUtils.config)) {
        do {
            try realm.write {
                realm.add(self, update: true)
            }
        } catch {}
    }
    static func all(in realm: Realm = try! Realm(configuration: RealmUtils.config)) -> [Message] {
        return Array(realm.objects(Message.self).sorted(by: { $0.sentDate.compare($1.sentDate) == .orderedAscending }))
    }
    static func all2(in realm: Realm = try! Realm(configuration: RealmUtils.config), withTopic id: String) -> [Message] {
        return Array(realm.objects(Message.self).filter({$0.idAlbum == id}).sorted(by: { $0.sentDate.compare($1.sentDate) == .orderedAscending }))
    }
    func remove(in realm: Realm = try! Realm()) {
        do {
            try realm.write {
                realm.delete(self)
            }
        } catch {}
    }
    static func getMessagesByAlbumId(idAlbum:String) -> [Message]{
        var listaMsg : [Message]=[]
        for msg in Message.all(){
            if msg.idAlbum == idAlbum{
                listaMsg.append(msg)
                //print(msg.sentDate)
            }
        }
        return listaMsg
    }
}
