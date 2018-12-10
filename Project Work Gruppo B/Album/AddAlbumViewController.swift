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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let titleAlbum = nameOutlet.text ?? ""
        let infoAlbum = infoOutlet.text ?? ""
        
        guard !titleAlbum.isEmpty && !infoAlbum.isEmpty else {
            self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "uno o più campi sono vuoti"), animated: true, completion: nil)
            return
        }
        var album = Album(title: titleAlbum, info: infoAlbum, completed: false)
        addAlbumDelegate.addAlbum(album: album)
        self.navigationController?.popViewController(animated: true)

//        NetworkManager.addAlbum(album: <#T##Album#>, completion: <#T##(Bool) -> ()#>)
//
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
