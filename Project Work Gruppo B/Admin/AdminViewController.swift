//
//  AdminViewController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var listaAlbum : [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listaAlbum.append(Album(title: "Coop", info: "supermercati coop in provincia di Padova", completed: false))
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

extension AdminViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as! AdminTableViewCell
        
        cell.titleAlbum.text = listaAlbum[indexPath.row].title
        cell.descriptionAlbum.text = listaAlbum[indexPath.row].info
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
}

