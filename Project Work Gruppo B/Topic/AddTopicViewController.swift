//
//  CreateAlbumController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
protocol AddTopicDelegate{
    func addTopic(topic: Topic)
}
class AddTopicViewController: UIViewController {
    var addTopicDelegate : AddTopicDelegate!
    var titleTopic : String = ""
    var infoTopic : String = ""
    var topic : Topic!
    //var topic : Topic = Topic()
    
    @IBOutlet weak var infoTopicTextField: UITextField!
    @IBOutlet weak var titleTopicTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addTopicAction(_ sender: Any) {
        titleTopic = titleTopicTextField.text ?? ""
        infoTopic = infoTopicTextField.text ?? ""
        
        guard !titleTopic.isEmpty && !infoTopic.isEmpty else {
            self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "uno o più campi sono vuoti"), animated: true, completion: nil)
            return
        }
        topic = Topic(title: titleTopic, info: infoTopic)
        addTopicDelegate.addTopic(topic: topic)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    @IBAction func addUsersActionButton(_ sender: Any) {
        titleTopic = titleTopicTextField.text ?? ""
        infoTopic = infoTopicTextField.text ?? ""
        
        guard !titleTopic.isEmpty && !infoTopic.isEmpty else {
            self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "uno o più campi sono vuoti"), animated: true, completion: nil)
            return
        }
        
        topic = Topic(title: titleTopic, info: infoTopic)
        self.performSegue(withIdentifier: R.segue.addTopicViewController.segueToAddUser, sender: self)
        
        
        /*topic = Topic(title: titleAlbum, info: infoAlbum, completed: nil)
         NetworkManager.addAlbum(album: album) { (success) in
         if success{
         self.album.save()
         self.performSegue(withIdentifier: "segueToAddUserToAlbum", sender: self)
         }else{
         self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "operazione non riuscita"), animated: true, completion: nil)
         }
         
         }
         */
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? AddUsersTopicViewController{
            destinationSegue.addTopicDelegate = self.addTopicDelegate
            destinationSegue.topic = topic
        }
    }
    
}
