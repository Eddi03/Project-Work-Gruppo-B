//
//  FirebaseChat.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 18/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//
import UIKit
import Firebase
import FirebaseFirestore
import CodableFirebase

class FirebaseChatDatabase: NSObject {
    
    // Initialize Cloud Firestore through Firebase
    static var db = Firestore.firestore()
    
    private static var messageListener: ListenerRegistration?
    
    static func sendMessage(chanelID : String, directChat: Bool, message: Message, completion: @escaping (Bool) -> Void) {
        
         guard let id = NetworkManager.getMyID() else { completion(false); return }
        
        do {
            message.messageText = try Cryptor.share.encryptMessage(message: message.messageText)
            let data = try FirebaseEncoder().encode(message)
            
            db.collection("Chat").document(chanelID).collection(directChat ? "Private" : "Tasks").document(message.id).setData(data as! [String : Any], merge: true) { error in
                if let error = error {
                    UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: "Errore", message: error.localizedDescription, closeAction: { _ in
                        completion(false)
                    }), animated: true, completion: nil)
                    return
                }
                
                message.save()
                completion(true)
                
            }
            
        } catch let error {
            
            UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: "Errore", message: error.localizedDescription, closeAction: { _ in
                completion(false)
            }), animated: true, completion: nil)
            return
        }
        
        
    }
    
    /*
    static func sendMessage(chanelID : String, directChat: Bool, message: Message, completion: @escaping (Bool) -> Void) {
        
        guard let id = NetworkManager.getMyID() else { completion(false); return }
        
        do {
            message.messageText = try Cryptor.share.encryptMessage(message: message.messageText)
            let data = try FirebaseEncoder().encode(message)
            
            //post
            db.collection("Chat").document(chanelID).collection(directChat ? "Private" : "Tasks").document(chanelID).setData([message.id : data], merge: true) { error in
                if let error = error {
                    UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: "errore", message: error.localizedDescription, closeAction: { _ in
                        completion(false)
                    }), animated: true, completion: nil)
                    return
                }
                
                message.save()
                completion(true)
                
            }
            
        } catch let error {
            
            UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: "errore", message: error.localizedDescription, closeAction: { _ in
                completion(false)
            }), animated: true, completion: nil)
            return
        }
        
        
    }*/
    
    //get
    static func listenerMessages(chanelID : String, directChat: Bool, completion: @escaping (Bool) -> Void) {
        
        guard let id = NetworkManager.getMyID() else { completion(false); return }
        
        messageListener = db.collection("Chat").document(chanelID).collection(directChat ? "Private" : "Tasks").whereField("topicId", isEqualTo: chanelID).addSnapshotListener { querySnapshot, error in
        
                guard let snapshot = querySnapshot else {
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title:"Errore", message: error?.localizedDescription, closeAction: { _ in
                    completion(false)
                }), animated: true, completion: nil)
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                do {
                    let data = try FirebaseDecoder().decode(Message.self, from: diff.document.data())
                    if (diff.type == .added) {
                        data.save()
                    }
                    if (diff.type == .modified) {
                        data.save()
                    }
                    if (diff.type == .removed) {
                        data.remove()
                    }
                } catch let error {
                    UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: "Errore", message: error.localizedDescription, closeAction: { _ in
                        completion(false)
                    }), animated: true, completion: nil)
                    
                    return
                }
                
            }
            completion(true)
        }
    }
    
    /*
    static func listenerMessages(chanelID : String, directChat: Bool, completion: @escaping (Bool) -> Void) {
        
        guard let id = NetworkManager.getMyID() else { completion(false); return }
        
        messageListener = db.collection("Chat").document(chanelID).collection(directChat ? "Private" : "Tasks").document(chanelID).addSnapshotListener { querySnapshot, error in
            
            guard let snapshot = querySnapshot else {
                UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: "errore", message: error?.localizedDescription, closeAction: { _ in
                    completion(false)
                }), animated: true, completion: nil)
                return
            }
            
            guard let datas = snapshot.data()?.values else { completion(true); return }
            
            for (index, data) in datas.enumerated() {
                do {
                    try FirebaseDecoder().decode(Message.self, from: data).save()
                    if index == datas.count - 1 {
                      completion(true)
                    }
                } catch let error {
                    UIApplication.topViewController()?.present(GeneralUtils.share.alertBuilder(title: "errore", message: error.localizedDescription, closeAction: { _ in
                        completion(false)
                    }), animated: true, completion: nil)
                    return
                }
            }
            
        }
    }*/
    
    static func removeMessageListener() {
        messageListener?.remove()
    }
    
    
}

