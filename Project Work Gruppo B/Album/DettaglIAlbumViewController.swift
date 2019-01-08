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
  
    @IBOutlet weak var titoloField: UILabel!
    
    @IBOutlet weak var descrizioneField: UILabel!
    
    @IBOutlet weak var creatoField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titoloField.text = album.title
        descrizioneField.text = album.info
        creatoField.text = "Creato il: "+album.creationDate
    }
    
    @IBAction func archiviaAlbumAction(_ sender: Any) {
        let alert = UIAlertController(title: "Album completo", message: "Vuoi segnare l'album come completo?", preferredStyle: .alert)
        let actionNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(actionNo)
        alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
            self.album.changeData(completed: true)
            NetworkManager.addAlbum(topic: self.topic, album: self.album, bool: false, completion: {success in
                if success {
                    print("modificato il completed album")
                }
            })
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func deleteAlbumAction(_ sender: Any) {
    }
}
