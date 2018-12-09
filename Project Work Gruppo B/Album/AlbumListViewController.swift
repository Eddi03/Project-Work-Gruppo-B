//
//  AdminListaAlbumController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    
    var titleAlbum : String = ""
    var infoAlbum : String = ""
    
    var listaAlbum : [Album] = []
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaAlbum.append(Album(title: "Coop", info: "cnd hduif", completed: nil))
        // Do any additional setup after loading the view.
        /*
        NetworkManager.getAlbumsToComplete { (listaAlbum) in
        print("listaaaaaaaa", listaAlbum)
        self.listaAlbum = listaAlbum
        //aggiungo a realm gli album
        for album in self.listaAlbum {
            album.save()
            }
        }
 */
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

extension AlbumListViewController : UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaAlbum.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.kIdentifier, for: indexPath) as! AlbumTableViewCell
        
        cell.titleAlbumTextField.text = listaAlbum[indexPath.row].title
        cell.infoAlbumTextField.text = listaAlbum[indexPath.row].info
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
}
