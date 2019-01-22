//
//  AddUsersTopicController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
class AddUsersTopicViewController: UIViewController {
    
    var addTopicDelegate : AddTopicDelegate!
    var users : [User] = []
    var usersToAdd : [String] = []
    var currentUsers : [String] = []
    var topic : Topic!
    var images : [Image] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
        NetworkManager.getUsers(completion: {   success in
            if success {
                self.users = User.all()
                self.removeCurrentUser()
                self.getCurrentUsers()
                print("lista utenti", self.users)
                self.tableView.reloadData()
            }else{
                GeneralUtils.share.alertError(title: "errore", message: "")
            }
        })
    }
    func getCurrentUsers(){
        var a : [String] = []
        a = topic.getUsers()
        if a.count>0{
            a.remove(at: a.firstIndex(of: NetworkManager.getMyID()!)!)
        }
        self.currentUsers = a
        self.usersToAdd = a   }
    func removeCurrentUser(){
        var a : [User] = []
        let id = NetworkManager.getMyID()
        for i in users{
            if i.id != id{
                a.append(i)
            }
        }
        self.users = a
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTopicAction(_ sender: Any) {
        guard !usersToAdd.isEmpty else{
            return
        }
        for i in currentUsers{
            guard let position = topic.getUsers().firstIndex(of: i) else{
                return
            }
            topic.removeUser(index: position)
        }
        for i in usersToAdd{
            topic.addingUser(id: i)
        }
        NetworkManager.addTopic(topic: topic, completion: {
            success in
            if success {
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                GeneralUtils.share.alertError(title: "Attenzione", message: "Utenti non aggiunti")
            }
        })
        
    }
    
    
}

extension AddUsersTopicViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddUsersTableViewCell.kIdentifier, for: indexPath) as! AddUsersTableViewCell
        
        if let image = Image.getImageById(id: self.users[indexPath.row].id){
            cell.imageProfile.image = UIImage(data: image.image!)
        }else{
            if let imageProfile = self.users[indexPath.row].image{
                NetworkManager.dowloadImage(withURL: imageProfile, completion: { (image) in
                    let img = Image(image: image?.pngData(),id: self.users[indexPath.row].id)
                    img.save()
                    self.images = Image.all()
                })
            }else{
                cell.imageProfile.image = UIImage(named: "User Placeholder")
            }
        }
        
        
        
        cell.name.text = self.users[indexPath.row].getFullName()
        
        cell.backgroundColor = UIColor.white
        cell.checkedImage.isHidden = false
        if usersToAdd.contains(users[indexPath.item].id) {
            cell.isSelected=true
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            cell.checkedImage.image = (UIImage(named: "Checked"))
        }
        else{
            cell.isSelected=false
            cell.checkedImage.image = (UIImage(named: "UnCheckedList"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //add the selected cell contents to _selectedCells arr when cell is selected
        
        usersToAdd.append(users[indexPath.row].id)
        debugPrint(usersToAdd[0])
        tableView.reloadRows(at: [indexPath], with: .fade)
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //remove the selected cell contents from _selectedCells arr when cell is De-Selected
        
        if let position = usersToAdd.firstIndex(of:users[indexPath.row].id){
            usersToAdd.remove(at: position)
        }
        tableView.reloadRows(at: [indexPath],with: .fade)
    }
    
    
}
