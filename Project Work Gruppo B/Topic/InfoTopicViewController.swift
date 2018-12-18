//
//  InfoTopicViewController.swift
//  Project Work Gruppo B
//
//  Created by Eddi Raimondi on 11/12/2018.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class InfoTopicViewController: UIViewController {

    @IBOutlet weak var deleteOutlet: UIButton!
    @IBOutlet weak var editOutlet: UIButton!
    @IBAction func goToEditMembersAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: R.segue.infoTopicViewController.segueToEditMembers, sender: self)
    }
    
    @IBOutlet weak var navBarTitleTopic: UINavigationItem!{
        didSet{
            navBarTitleTopic.title = R.string.localizable.kDetailNavBarsTitle()
        }
    }
        @IBOutlet weak var descriptionTitleTopic: UILabel!{
        didSet{
         descriptionTitleTopic.text = R.string.localizable.kDetailLabelDescription()
        }
    }
    @IBOutlet weak var descriptionTopic: UILabel!

    var addTopicDelegate : AddTopicDelegate!
    var users : [User] = []
    var usersToAdd : [String] = []
    var topic : Topic?
    var currentUser : User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var idUser = NetworkManager.getMyID()
        var user = User.getUserById(withid: idUser!)
        
        if user!.supervisor {
            editOutlet.isHidden = false
            deleteOutlet.isHidden = false
        }
        else {
            editOutlet.isHidden = true
            deleteOutlet.isHidden = true
        }
        
        deleteOutlet.layer.cornerRadius = 20
        deleteOutlet.clipsToBounds = true
        editOutlet.layer.cornerRadius = 20
        editOutlet.clipsToBounds = true
      
      
      
        //get user from topic
        for userId in topic?.getUsers() ?? []{
            var userObject = User.getUserById(withid: userId)
            users.append(userObject ?? User())
        }
        
        descriptionTopic.text = topic?.info
        
        print("lista utenti del topic",users)
    }
    
   
    @IBAction func deleteTopicAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Attenzione", message: "Sei sicuro di voler eliminare il topic?", preferredStyle: .alert)
        let si = UIAlertAction(title: "Si", style: .default){
            UIAlertAction in
            NetworkManager.deleteTopic(idTopic: self.topic!.id, completion: { success in
                if success{
                    //elimino su relam (prima elimino gli album)
                    for albumId in self.topic?.getAlbums() ?? []{
                        var album = Album.getAlbumById(id: albumId)
                        NetworkManager.deleteAlbum(topic: self.topic!, idAlbum: albumId, completion: {success in
                            if success {
                                album?.delete()
                            }
                        })
                        
                    }
                    self.topic!.delete()
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
        let no = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(si)
        alert.addAction(no)
        self.present(alert, animated: true)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? AddUsersTopicViewController{
            destinationSegue.topic = topic
        }
    }

}
