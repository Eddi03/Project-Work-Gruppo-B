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
    
    @IBOutlet weak var navBarSaveNewAlbum: UIBarButtonItem!{
        didSet {
            navBarSaveNewAlbum.title = R.string.localizable.kAccountSaveButton()
        }
    }
    @IBOutlet weak var nameOutlet: UITextField! {
        didSet {
            nameOutlet.placeholder = R.string.localizable.kNewTopicTitle()
        }
    }
    
    @IBOutlet weak var infoOutlet: UITextField!{
        didSet {
            infoOutlet.placeholder = R.string.localizable.kNewTopicDescription()
        }
    }
    
    var topic : Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        var album: Album = Album()
        guard let topic = Topic.getTopicById(id: topic.id) else {return}
        print(topic)
        let currentName = nameOutlet.text ?? ""
        let currentInfo = infoOutlet.text ?? ""

        album = Album(title: currentName, info: currentInfo, completed: false)
        
        NetworkManager.addAlbum(topic: topic, album: album){(success) in
            if success{
                album.save()
                self.navigationController?.popViewController(animated: true)
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
