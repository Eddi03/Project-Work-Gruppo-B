//
//  CreateAlbumController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AddTopicViewController: UIViewController {

    var titleTopic : String = ""
    var infoTopic : String = ""
    //var topic : Topic = Topic()
   
    @IBOutlet weak var infoTopicTextField: UITextField!
    @IBOutlet weak var titleTopicTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func avantiActionButton(_ sender: Any) {
        titleTopic = titleTopicTextField.text ?? ""
        infoTopic = infoTopicTextField.text ?? ""
        
        guard !titleTopic.isEmpty && !infoTopic.isEmpty else {
            self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "uno o più campi sono vuoti"), animated: true, completion: nil)
            return
        }
        
        self.performSegue(withIdentifier: "segueToAddUser", sender: self)
        
        
        /*topic = Topic(title: titleAlbum, info: infoAlbum, completed: nil)
        NetworkManager.addAlbum(album: album) { (success) in
            if success{
                self.album.save()
                self.performSegue(withIdentifier: "segueToAddUserToAlbum", sender: self)
            }else{
                self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "operazione non riuscita"), animated: true, completion: nil)
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
