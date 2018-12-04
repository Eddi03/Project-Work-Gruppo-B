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
            "Name": user.Name,
            "Surname": user.Surname,
            "Email" : user.Email,
            "Image" : user.Image,
            "Supervisor" : user.Supervisor,
            "Id" : Auth.auth().currentUser?.uid ?? ""
            ] ,merge: true,completion: { (err) in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion(false)
                }
                completion(true)
        })
    }
    static func addAlbum(album: Album,completion: @escaping (Bool)-> ()){
        db!.collection("Albums").document(album.id).setData([(album.id)!:[
            "Title" : album.title,
            "Info" : album.info,
            "Users" : album.getUsers(),
            "Photos" : album.getPhotos(),
            "Completed" : false
            ] ],merge: true,completion: { (err) in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion(false)
                }
                completion(true)
        })
    }

    static func getAlbumsToComplete(id:String!, completion : @escaping([Album]) -> Void){
        var c : String!
        db!.collection("Albums").getDocuments { (documentSnap, error) in
            var albumsToComplete : [Album] = []
            
            if let error = error{
                print(error)
            }
            else{
                
                guard let documentSnap = documentSnap else{ return }
                for values in documentSnap.documents{
                    let album = Album(title: values["Title"] as? String, info: values["Info"] as? String)
                    albumsToComplete.append(album)
                }
                print(albumsToComplete)
            }
            completion(albumsToComplete)
        }
    }
    static func getUsers(completion : @escaping([User]) -> Void){
        db!.collection("Users").getDocuments { (documentSnap, error) in
            var usersList : [User] = []
            
            if let error = error{
                print(error)
            }
            else{
                
                guard let documentSnap = documentSnap else{ return }
                for document in documentSnap.documents{
                    let name = document["Name"] as! String
                    let surname = document["Surname"] as! String
                    let image = document["Image"] as? String
                    let email = document["Email"] as! String
                    let supervisor = document["Supervisor"] as? Bool
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
                        debugPrint(User.getUser(withid: uid))
                        completion(true)
                    }catch{
                        print(error)
                        completion(false)
                    }
                }
                
        
                
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
            
            completion(true)
        }
    }
    
    static func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            print(error)
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
}
