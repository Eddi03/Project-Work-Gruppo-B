//
//  AddAlbumViewController.swift
//  Project Work Gruppo B
//
//  Created by Michele Pertile on 10/12/2018.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
protocol AddAlbumDelegate{
    func addAlbum(album : Album)
}
class AddAlbumViewController: UIViewController {
    var addAlbumDelegate : AddAlbumDelegate!
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var infoOutlet: UITextField!
    
    var idTopic : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        var album: Album = Album()
        guard let topic = Topic.getTopicById(id: idTopic) else {return}
        
        let currentName = nameOutlet.text ?? ""
        let currentInfo = infoOutlet.text ?? ""

        album = Album(title: currentName, info: currentInfo, completed: nil)
        
        NetworkManager.addAlbum(topic: topic, album: album){(success) in
            if success{
                self.dismiss(animated: true, completion: nil)
            }else{
                GeneralUtils.share.alertError(title: "Attenzione", message: "non è stato salvato l'album")
            }
        }
        

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
