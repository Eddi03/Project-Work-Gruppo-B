//
//  DettaglIAlbumViewController.swift
//  Project Work Gruppo B
//
//  Created by Eddi Raimondi on 18/12/2018.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class DettaglIAlbumViewController: UIViewController {

    var album : Album!
    var topic : Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.white
        
    }
    
    @IBAction func archiviaAlbumAction(_ sender: Any) {
        //lo fa solo se prima l'operatore ha messo completed a true
        if album.completed {
            
            let alert = UIAlertController(title: "Album completo", message: "Vuoi segnare l'album come completo?", preferredStyle: .alert)
            let actionNo = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
            alert.addAction(actionNo)
            alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
                NetworkManager.deleteAlbum(topic: self.topic, idAlbum: self.album.id, completion: {success in
                    if success {
                        print("eliminato il completed album")
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                self.album.changeData(completed: false)
                NetworkManager.addAlbum(topic: self.topic, album: self.album, bool: false, completion: {success in
                    if success {
                        print("modificato il completed album")
                    }
                })
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteAlbumAction(_ sender: Any) {
    }
}
