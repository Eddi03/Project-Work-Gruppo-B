//
//  AdminViewController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var listaTopic : [Topic] = []
    var admin : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listaTopic.append(Topic(title: "ciao", info: "idjwbocfh dhacw dbdc "))
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func logout(_ sender: Any) {
        NetworkManager.logOut()
        let storyboard = UIStoryboard(name: "WhiteStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        present(viewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaTopic.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! TopicTableViewCell
        
        cell.titleTopic.text = listaTopic[indexPath.row].title
        cell.infoTopic.text = listaTopic[indexPath.row].info
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
}

