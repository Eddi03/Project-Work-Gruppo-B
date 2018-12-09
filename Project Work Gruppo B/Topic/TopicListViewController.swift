//
//  AdminViewController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let EMPTY_LIST = 0
    private let TOPIC_INFO = 1
    private let ADD_TOPIC = 2
    
    @IBAction func addTopicAction(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.mainViewController.segueToAddTopic, sender: self)
    }
    var searched = [Topic]()
    var searching = false
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var listaTopic : [Topic] = []
    var admin : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listaTopic.append(Topic(title: "ciao", info: "idjwbocfh dhacw dbdc "))
        search.delegate = self
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func actionToAccount(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.mainViewController.segueToAccount, sender: self)
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == TOPIC_INFO{
            if searching{
                return searched.count
            }
            else{
                return listaTopic.count
            }
        }
        if listaTopic.isEmpty{
            if section == EMPTY_LIST{
                return 1
            }
        }
        if admin && section == ADD_TOPIC{
            return 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.section == TOPIC_INFO{
            self.performSegue(withIdentifier: R.segue.mainViewController.segueToAlbums, sender: self)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case TOPIC_INFO:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopicTableViewCell.kIdentifier, for: indexPath) as! TopicTableViewCell
            
            if searching {
                cell.titleTopic.text = searched[indexPath.row].title
                cell.infoTopic.text = searched[indexPath.row].info
            } else {
                cell.titleTopic.text = listaTopic[indexPath.row].title
                cell.infoTopic.text = listaTopic[indexPath.row].info
            }
            return cell
        case ADD_TOPIC:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddTopicTableViewCell.kIdentifier, for: indexPath) as! AddTopicTableViewCell
            return cell
        case EMPTY_LIST:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.kIdentifier, for: indexPath) as! EmptyTableViewCell
            cell.message.text = "non ghe se niente"
            return cell
        default:
            return UITableViewCell()
    }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case TOPIC_INFO:
            return 140
        case EMPTY_LIST:
            return 80
        case ADD_TOPIC:
            return 80
        default:
            return 0
        }
    }
    
    
    
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searched = listaTopic.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}
