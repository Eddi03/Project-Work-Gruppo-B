//
//  AdminListaAlbumController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    private let EMPTY_LIST = 0
    private let ALBUM_INFO = 1
    private let ADD_ALBUM = 2
    
    var titleAlbum : String = ""
    var infoAlbum : String = ""
    
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
        /*
        NetworkManager.getAlbums{ (listaAlbums) in
            self.albums = listaAlbums
            print("coseeee albummmmm", self.albums)
        }
 */
    }
    override func viewDidAppear(_ animated: Bool) {
        NetworkManager.getAlbums{ (success) in
            if success{
            self.albums = Album.all()
            print("coseeee albummmmm", self.albums)
            self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addAlbumAction(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.albumListViewController.segueToAddAlbum, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //albums = Album.all()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? AddAlbumViewController{
            destinationSegue.addAlbumDelegate = self
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
            }
            return cell
        case ADD_ALBUM:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddAlbumTableViewCell.kIdentifier, for: indexPath) as! AddAlbumTableViewCell
            return cell
       
        case EMPTY_LIST:
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyListAlbumsTableViewCell.kIdentifier, for: indexPath) as! EmptyListAlbumsTableViewCell
            cell.message.text = "non ghe se niente"
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case ALBUM_INFO:
            return 140
        case EMPTY_LIST:
            return 80
        case ADD_ALBUM:
            return 80
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == ALBUM_INFO{
            self.performSegue(withIdentifier: R.segue.albumListViewController.segueToAddAlbum, sender: self)
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
        album.save()
        albums = Album.all()
        tableView.reloadData()
    }
    
    
}
