//
//  CreateAlbumController.swift
//  Project Work Gruppo B
//
//  Created by Sarah Dal Santo on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class CreateAlbumController: UIViewController {

    var titleAlbum : String = ""
    var infoAlbum : String = ""
   
    @IBOutlet weak var infoAlbumTextField: UITextField!
    @IBOutlet weak var titleAlbumTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func avantiActionButton(_ sender: Any) {
        titleAlbum = titleAlbumTextField.text ?? ""
        infoAlbum = infoAlbumTextField.text ?? ""
        
        guard !titleAlbum.isEmpty && !infoAlbum.isEmpty else {
            self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "uno o più campi sono vuoti"), animated: true, completion: nil)
            return
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
