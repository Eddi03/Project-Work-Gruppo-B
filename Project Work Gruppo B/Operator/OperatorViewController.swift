//
//  ListViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class OperatorViewController: UIViewController {
    var albumsToComplete : [Album] = []
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    override func viewWillAppear(_ animated: Bool) {
//        NetworkManager.getAlbumsToComplete(role: "OperatorAssigned",value: ){ (albumsToComplete) in
//            self.albumsToComplete = albumsToComplete
//            self.tableView.delegate = self as? UITableViewDelegate
//            self.tableView.dataSource = self as? UITableViewDataSource
//
//        }
//    }
    @IBAction func logoutAction(_ sender: Any) {
        NetworkManager.logOut()
        let storyboard = UIStoryboard(name: "WhiteStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        present(viewController, animated: true, completion: nil)    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension OperatorViewController: UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0{
//            return 1
//        }
//        if section == 1{
//            return albumsToComplete.count
//        }
//    }
////    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
////        if editingStyle == .delete {
////            NetworkManager.delete(id: shoppingList[indexPath.row].id)
////            shoppingList.remove(at: indexPath.row)
////            self.tableView.reloadData()
////        }
////    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.kIdentifier, for: indexPath) as! ItemTableViewCell
//        let album = albumsToComplete[indexPath.row]
//        cell.title.text = album.title
//        //cell.number.text = String(item.number)
//        return cell
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//}
