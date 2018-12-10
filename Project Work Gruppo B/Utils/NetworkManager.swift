//
//  NetworkManager.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 28/11/18.
//  Copyright © 2018 Eddi. All rights reserved.
//


import UIKit
import FirebaseFirestore
import Firebase
import CodableFirebase


class NetworkManager : NSObject{
    private static var ref : DocumentReference!
    
    private static var db: Firestore?
    private static var storageRef : StorageReference?
    
    static func initFirebase(){
        FirebaseApp.configure()
        db = Firestore.firestore()
        storageRef = Storage.storage().reference()
    }
    
    static func getMyID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    static func addUser(user : User,completion: @escaping (Bool)-> ()){
        db!.collection("Users").document((Auth.auth().currentUser?.uid)!).setData([
            "name": user.name,
            "surname": user.surname,
            "email" : user.email,
            "image" : user.image,
            "supervisor" : user.supervisor,
            "id" : Auth.auth().currentUser?.uid ?? ""
            ] ,merge: true,completion: { (err) in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion(false)
                }
                completion(true)
        })
    }
   
    
//    static func getAlbumsToComplete(completion : @escaping([Album]) -> Void){
//
//        db!.collection("Albums").getDocuments { (documentSnap, error) in
//            var albumsToComplete : [Album] = []
//
//            if let error = error{
//                print(error)
//            }
//            else{
//
//                guard let documentSnap = documentSnap else{ return }
//                for values in documentSnap.documents{
//                    var isMyAlbum = false
//                    if let completed = values["completed"] as? Bool, !completed{
//                        if let users = values["users"] as? [String]{
//                            for i in users{
//                                if i == Auth.auth().currentUser?.uid{
//                                    isMyAlbum = true
//                                }
//
//                            }
//                        }
//                        if isMyAlbum{
//                            let album = Album(title: values["Title"] as? String, info: values["Info"] as? String, completed: false)
//                            if let photos = values["photos"] as? [Photo]{
//                                for i in photos{
//                                    album.addingPhoto(photo: i)
//                                }
//                            }
//                            if let users = values["users"] as? [String]{
//                                for i in users{
//                                //    Topic.addingUser(id: i)
//
//                                }
//                            }
//
//                            albumsToComplete.append(album)}
//
//                    }
//                }
//                print(albumsToComplete)
//            }
//            completion(albumsToComplete)
//        }
//    }
    static func getUsers(completion : @escaping([User]) -> Void){
        db!.collection("Users").getDocuments { (documentSnap, error) in
            var usersList : [User] = []
            
            if let error = error{
                print(error)
            }
            else{
                
                guard let documentSnap = documentSnap else{ return }
                for document in documentSnap.documents{
                    let name = document["name"] as! String
                    let surname = document["surname"] as! String
                    let image = document["image"] as? String
                    let email = document["email"] as! String
                    let supervisor = document["supervisor"] as? Bool
                    let user = User(email: email, name: name, surname: surname, image: image, supervisor:supervisor)
                    usersList.append(user)
                }
            }
            completion(usersList)
        }
        
    }
    
    static func getUserLogged(completion : @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.db?.collection("Users").document(uid).getDocument(completion: { (documentSnapshot, error) in
            if let error = error{
                print(error)
                completion(false)
            }
            else{
                if let document = documentSnapshot?.data(){
                    do{
                        debugPrint(document)
                        try FirebaseDecoder().decode(User.self, from: document).save()
                        debugPrint(User.getUser(withid: uid)!)
                        completion(true)
                    }catch{
                        print(error)
                        completion(false)
                    }
                }
                
                
                
            }
        })
        
    }
    static func checkIfDataIsFilled(completion : @escaping(Bool) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let document = db?.collection("Users").document(uid)
        document?.getDocument(completion: { (documentSnapshot, error) in
            if let error = error{
                debugPrint(error)
                completion(false)
            }
            else{
                guard let document = documentSnapshot?.data() else{
                    completion(false)
                    return
                }
                debugPrint(document)
                completion(true)
            }
        })
    }
    
    static func signup(email: String,password: String, completion: @escaping (Bool)-> ()){
        
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            if error != nil{
                UIApplication.topViewController()?.present(GeneralUtils.share.alertError(title: "Error", message: error?.localizedDescription), animated: true, completion: nil)
            }
            
            guard let user = authResult?.user else {
                UIApplication.topViewController()?.present(GeneralUtils.share.alertError(title: "Error", message: error?.localizedDescription), animated: true, completion: nil)
                completion(false)
                return
            }
            debugPrint(user)
            completion(true)
        }
        
        
    }
    static func login(email: String, password: String, completion: @escaping (Bool)->()){
        Auth.auth().signIn(withEmail: email,password: password){(user,error) in
            if error != nil{
                UIApplication.topViewController()?.present(GeneralUtils.share.alertError(title: "Error", message: error?.localizedDescription), animated: true, completion: nil)
            }
            guard let user = user else{
                /*UIApplication.topViewController()?.present(GeneralUtils.share.alertError(title: R.string.localizable.kError, message: error?.localizedDescription, closeAction: {
                 completion(false)
                 }),animated: true,completion: nil)
                 return*/
                completion(false)
                return
            }
            debugPrint(user)
            
            completion(true)
        }
    }
    
    static func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            print(error!)
        }
    }
    
    static func logOut(){
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                
            } catch let error as NSError {
                UIApplication.topViewController()?.present(GeneralUtils.share.alertError(title: "Error", message: error.localizedDescription), animated: true, completion: nil)
            }
        }
    }
    
    
    static func uploadImageProfile(withData data: Data, forUserID id: String, completion: @escaping (String?) -> ()) {
        
        guard let storageRef = storageRef else { completion(nil); return }
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("profileImages/\(id).jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let _ = riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                completion(nil)
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            debugPrint(size)
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    completion(nil)
                    return
                }
                
                debugPrint(downloadURL)
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    static func dowloadImageProfile(withURL url: String, completion: @escaping (UIImage?) -> ()) {
        
        // Create a reference from an HTTPS URL
        // Note that in the URL, characters are URL escaped!
        let httpsReference = Storage.storage().reference(forURL: url)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                debugPrint(error)
                completion(nil)
            } else {
                // Data for "images/island.jpg" is returned
                guard let data = data, let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                completion(image)
            }
        }    
    }
    static func uploadPhoto(withData data: Data, albumId: String, photoId: String, completion: @escaping (String?) -> ()) {
        
        guard let storageRef = storageRef else { completion(nil); return }
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("Albums/\(albumId)/\(photoId).jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let _ = riversRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                completion(nil)
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            debugPrint(size)
            // You can also access to download URL after upload.
            riversRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    completion(nil)
                    return
                }
                
                debugPrint(downloadURL)
                completion(downloadURL.absoluteString)
            }
        }
    }
    
    static func getUserLoggedData(completion : @escaping(User) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        self.db?.collection("Users").document(uid).getDocument(completion: { (documentSnapshot, error) in
            if let error = error{
                print(error)
                //completion(false)
            }
            else{
                if let document = documentSnapshot?.data(){
                    do{
                        debugPrint(document)
                        try FirebaseDecoder().decode(User.self, from: document).save()
                        let user = (User.getUser(withid: uid)!)
                        completion(user)
                    }catch{
                        print(error)
                       // completion(false)
                    }
                }
                
                
                
            }
        })
        
    }
    
    //TOPIC
    
    static func addTopic(topic: Topic, completion : @escaping(Bool)->Void){
        
        var id = UUID().uuidString
        db?.collection("Topics").document(id).setData([
            "id": topic.id,
            "title": topic.title,
            "info": topic.info,
            "users": topic.getUsers(),
            "albums": topic.getAlbums()
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
                completion(false)
            } else {
                print("Document successfully written!")
                topic.save()
                completion(true)
            }
        }
    }
    
    static func getTopics(completion : @escaping(Bool)->Void){
        var listaTopics : [Topic] = []
        NetworkManager.db?.collection("Topics").getDocuments{ (documentSnapshot, error) in
        guard let document = documentSnapshot else {return }
        for element in document.documents{
            debugPrint(element)
            /*
            let topic = Topic(title: element["title"] as! String, info: element["info"] as! String)
            listaTopics.append(topic) */
            
            do {
                try FirebaseDecoder().decode(Topic.self, from: element.data()).save()
                
            } catch let error {
                UIApplication.topViewController()?.present(GeneralUtils.share.alertError(title: "Error", message: error.localizedDescription), animated: true, completion: nil)
                completion(false)
                return //mi fa uscire dalla funzione
            }
            
        }
            completion(true)
            
        }
    }
    
    
    //ALBUM
    
    static func addAlbum(album: Album,completion: @escaping (Bool)-> ()){
        
        do{
            let parameters = try album.asDictionary()
            
            db!.collection("Albums").document(album.id).setData(
                parameters
                ,merge: true,completion: { (err) in
                    if let err = err {
                        print("Error adding document: \(err)")
                        completion(false)
                    }else{
                        album.save()
                        completion(true)
                    }
            })
            
            
        }catch let error{
            
        }
        /*
        db!.collection("Albums").document(album.id).setData([
            "title" : album.title,
            "info" : album.info,
            
            "photos" : album.getPhotos(),
            "completed" : false,
            "id" : album.id
            ],merge: true,completion: { (err) in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion(false)
                }else{
                    album.save()
                    completion(true)
                }
                 })
 */
    }
    static func getAlbums(completion : @escaping(Bool)->Void){
        var listaAlbums : [Album] = []
        NetworkManager.db?.collection("Albums").getDocuments{ (documentSnapshot, error) in
            guard let document = documentSnapshot else {return }
            for element in document.documents{
                debugPrint(element)
                /*
                let album = Album(title: element["title"] as! String, info: element["info"] as! String, completed: element["completed"] as! Bool)
                listaAlbums.append(album)
                */
                
                do {
                    try FirebaseDecoder().decode(Album.self, from: element.data()).save()
                    
                } catch let error {
                    UIApplication.topViewController()?.present(GeneralUtils.share.alertError(title: "Error", message: error.localizedDescription), animated: true, completion: nil)
                    completion(false)
                    return //mi fa uscire dalla funzione
                }
                
            }
            
            
            completion(true)
            
        }
    }
    
    
}
