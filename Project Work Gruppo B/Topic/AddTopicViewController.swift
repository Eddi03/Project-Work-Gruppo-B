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
    
    //var topicForAddUsers : Topic = Topic()
    //var topic : Topic = Topic()
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    @IBOutlet weak var navBarSaveButton: UIBarButtonItem!{
        didSet{
            navBarSaveButton.title = R.string.localizable.kAccountSaveButton()
        }
    }
        

    
    @IBOutlet weak var infoTopicTextField: UITextField!{
        didSet {
            infoTopicTextField.placeholder = R.string.localizable.kNewTopicDescription()
        }
    }
    
    @IBOutlet weak var titleTopicTextField: UITextField!{
        didSet {
            titleTopicTextField.placeholder = R.string.localizable.kNewTopicTitle()
        }
    }
    
    @IBOutlet weak var addUserButton: UIButton!{
        didSet {
            addUserButton.setTitle(R.string.localizable.kAddUserTopic(), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.white
        
    }
    
    
    @IBAction func addTopicAction(_ sender: Any) {
        titleTopic = titleTopicTextField.text ?? ""
        infoTopic = infoTopicTextField.text ?? ""
        
        guard !titleTopic.isEmpty && !infoTopic.isEmpty else {
            self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "uno o più campi sono vuoti"), animated: true, completion: nil)
            return
        }
        
        topic = Topic(title: titleTopic, info: infoTopic)
        NetworkManager.addTopic(topic: topic, completion: { success in
            if success {
                GeneralUtils.share.alertError(title: "Attenzione", message: "topic salvato con successo")
            }else{
                 GeneralUtils.share.alertError(title: "Attenzione", message: "topic NON salvato")
            }
        })
        
            
        
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
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? AddUsersTopicViewController{
            destinationSegue.addTopicDelegate = self.addTopicDelegate
            destinationSegue.topic = topic
            //destinationSegue.topicForAddUsers = topicForAddUsers
        }
    }
    
}
