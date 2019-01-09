//
//  AdminListaAlbumController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    
    @IBOutlet weak var searchBarAlbum: UISearchBar!{
        didSet {
            searchBarAlbum.placeholder = R.string.localizable.kSearchBarAlbum()
        }
    }
    @IBOutlet weak var navBarTopicDetails: UIBarButtonItem! {
        didSet {
            navBarTopicDetails.title = R.string.localizable.kNavBarTopicDetails()
        }
    }
    @IBAction func goToDetailsAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: R.segue.albumListViewController.segueToTopicDetails, sender: self)
    }
    
    private let EMPTY_LIST = 0
    private let ALBUM_INFO = 1
    private let ADD_ALBUM = 2
    
    var titleAlbum : String = ""
    var infoAlbum : String = ""
    var album : Album!
    var topic : Topic!
    var searched = [Album]()
    var searching = false
    
    var albums : [Album] = []
    var admin : Bool!
    @IBOutlet var search: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //albums.append(Album(title: "Coop", info: "cnd hduif", completed: nil))
       search.delegate = self
      
    }
//    override func viewDidAppear(_ animated: Bool) {
//        NetworkManager.getAlbums{ (success) in
//            if success{
//                self.albums = Album.getAlbumFromTopic(idCurrentTopic: self.topic.id)
//            print("coseeee albummmmm", self.albums, self.topic.id)
//            self.tableView.reloadData()
//            }
//        }
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        NetworkManager.getAlbums{ (success) in
            if success{
                self.albums = Album.getAlbumFromTopic(idCurrentTopic: self.topic.id)
//                print("coseeee albummmmm", self.albums, self.topic.id)
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    @IBAction func addAlbumAction(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.albumListViewController.segueToAddAlbum, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? AddAlbumViewController{
            destinationSegue.addAlbumDelegate = self
            destinationSegue.topic = topic
        }
        if let destinationSegue = segue.destination as? InfoTopicViewController{
            destinationSegue.topic = topic
        }
        if let destinationSegue = segue.destination as? PhotoCollectionViewController{
            destinationSegue.topic = topic
            destinationSegue.album = album
        }
        if let destinationSegue = segue.destination as? AdminPhotoCollectionViewController{
            destinationSegue.topic = topic
            destinationSegue.album = album
        }
        
    }
}


extension AlbumListViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == ALBUM_INFO{
            if searching{
                return searched.count
            }
            else{
                return albums.count
            }
        }
        if albums.isEmpty{
            if section == EMPTY_LIST{
                return 1
            }
        }
        if section == ADD_ALBUM{
            return 1
        }
        
        return 0
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case ALBUM_INFO:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.kIdentifier, for: indexPath) as! AlbumTableViewCell
            
            if searching {
                cell.title.text = searched[indexPath.row].title
                cell.info.text = searched[indexPath.row].info
            } else {
                cell.title.text = albums[indexPath.row].title
                cell.info.text = albums[indexPath.row].info
                
                if(albums[indexPath.row].completed){
                    let colore = UIColor(displayP3Red: 191/255, green: 244/255, blue: 238/255, alpha: 0.5)
                    cell.backgroundColor = colore
                    cell.albumIcon.image = UIImage(named: "Archivied")
                }
            }
            return cell
        case ADD_ALBUM:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddAlbumTableViewCell.kIdentifier, for: indexPath) as! AddAlbumTableViewCell
            return cell
       
        case EMPTY_LIST:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyListAlbumsTableViewCell.kIdentifier, for: indexPath) as! EmptyListAlbumsTableViewCell
            cell.message.text = "Vuoto"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case ALBUM_INFO:
            return 100
        case EMPTY_LIST:
            return 60
        case ADD_ALBUM:
            return 60
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == ADD_ALBUM{
            self.performSegue(withIdentifier: R.segue.albumListViewController.segueToAddAlbum, sender: self)
        }
        if indexPath.section == ALBUM_INFO{
            album = albums[indexPath.row]
            if admin{
                self.performSegue(withIdentifier: R.segue.albumListViewController.segueToAdmin, sender: self)
            }else{
                self.performSegue(withIdentifier: R.segue.albumListViewController.segueToOperator, sender: self)}
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}

extension AlbumListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searched = albums.filter({$0.title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}

extension AlbumListViewController : AddAlbumDelegate{
    func addAlbum(album: Album) {
        albums.insert(album, at: 0)
        tableView.reloadData()
    }
    
    
}
