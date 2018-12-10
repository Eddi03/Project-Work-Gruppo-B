//
//  AdminViewController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class TopicListViewController: UIViewController {
    private let EMPTY_LIST = 0
    private let TOPIC_INFO = 1
    private let ADD_TOPIC = 2
    
    @IBAction func addTopicAction(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.topicListViewController.segueToAddTopic, sender: self)
    }
    var searched = [Topic]()
    var searching = false
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var topics : [Topic] = []
    var admin : Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        topics = Topic.all()
        tableView.reloadData()
    }
    
    @IBAction func actionToAccount(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.topicListViewController.segueToAccount, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? AddTopicViewController{
            destinationSegue.addTopicDelegate = self
        }
        if let destinationSegue = segue.destination as? AlbumListViewController{
            destinationSegue.admin = admin
        }
    }
    
    
}

extension TopicListViewController : UITableViewDelegate, UITableViewDataSource {
    
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
                return topics.count
            }
        }
        if topics.isEmpty{
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
            self.performSegue(withIdentifier: R.segue.topicListViewController.segueToAlbums, sender: self)
            debugPrint("ciao")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case TOPIC_INFO:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopicTableViewCell.kIdentifier, for: indexPath) as! TopicTableViewCell
            
            if searching {
                cell.titleTopic.text = searched[indexPath.row].title
                cell.infoTopic.text = searched[indexPath.row].info
            } else {
                cell.titleTopic.text = topics[indexPath.row].title
                cell.infoTopic.text = topics[indexPath.row].info
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

extension TopicListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searched = topics.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}
extension TopicListViewController : AddTopicDelegate{
    func addTopic(topic: Topic) {
        topic.save()
        tableView.reloadData()
    }
}
