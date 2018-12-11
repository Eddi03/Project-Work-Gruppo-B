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
    var users : [String] = []
    var usersToAdd : [String] = []
    var topic : Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.users.append("Alessandro")
        self.users.append("Giorgio")
        self.users.append("Carlo")
        self.users.append("Luca")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTopicAction(_ sender: Any) {
        guard !usersToAdd.isEmpty else{
            return
        }
        for i in usersToAdd{
            topic.addingUser(id: i)
        }
        topic.save()
        addTopicDelegate.addTopic(topic: topic)
        self.navigationController?.popToRootViewController(animated: true)
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
        
        
        cell.name.text = self.users[indexPath.row]
        cell.backgroundColor = UIColor.clear
//        if let id = usersToAdd.filter({$0==users[indexPath.row]}).first{
//            cell.backgroundColor = UIColor.green
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell!.isSelected{
            cell!.isSelected = false
            if cell!.accessoryType == .none{
                cell!.accessoryType = .checkmark
                usersToAdd.append(users[indexPath.row])
            }
            else {
                if let position = usersToAdd.firstIndex(of:users[indexPath.row]){
                    usersToAdd.remove(at: position)
                }
                cell!.accessoryType = .none
            }
        }
    }
}
