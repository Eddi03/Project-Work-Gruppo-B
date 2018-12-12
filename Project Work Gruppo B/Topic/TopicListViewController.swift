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
    private var clickedTopicName: String = String()
    
    var topic : Topic!
    
    @IBOutlet weak var dfghj: UILabel!
    @IBAction func addTopicAction(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.topicListViewController.segueToAddTopic, sender: self)
    }
    
    var searched = [Topic]()
    var searching = false
    
    @IBOutlet weak var addTopicButton: UIButton!{
        didSet {
            addTopicButton.setTitle(R.string.localizable.kAddTopicButton(), for: .normal)
        }
    }
    
    
    @IBOutlet weak var labelEmptyTopic: UILabel!
    @IBOutlet weak var search: UISearchBar!{
        didSet{
            search.placeholder = R.string.localizable.kSearchBarPlaceholder()
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    var topics : [Topic] = []
    var admin : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.delegate = self        
    }
    override func viewDidAppear(_ animated: Bool) {
        print(Topic.all())
        NetworkManager.getTopics{ (success) in
            if success {
                self.topics = Topic.getTopicFromUser(idCurrentUser: NetworkManager.getMyID()!)
            print("id",NetworkManager.getMyID())
            print("coseeeeeeeeeeeee", self.topics)
            self.tableView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
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
            destinationSegue.topic = topic
           
        }
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let alert = UIAlertController(title: "Archivia", message: "Sei sicuro di voler archiviare il topic?", preferredStyle: .alert)
        let no = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(no)
        let yes = UIAlertAction(title: "Si", style: .default, handler: { action in
            
            let archivia = self.archiviaAction(at: indexPath)
        })
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
        
        //bisogna mettere il Album.completed = true
        let archivia = archiviaAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [archivia])
    }
    
    
    func archiviaAction(at indexPath: IndexPath) -> UIContextualAction{
        let topic = topics[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Archivia") { (action, view, completion) in
            completion(true)
        }
        // action.image = 🗂
        action.backgroundColor = .orange
        return action
        
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
                print("jneioqcfrfvbhrewf eiwvnhoewv")
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
            topic = topics[indexPath.row]
            self.performSegue(withIdentifier: R.segue.topicListViewController.segueToAlbums, sender: self)
            
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
            //cell.message.text = R.string.localizable.kNoTopicLabel()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case TOPIC_INFO:
            return 100
        case EMPTY_LIST:
            return 60
        case ADD_TOPIC:
            return 60
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
