//
//  AccountViewController.swift
//  Project Work Gruppo B
//
//  Created by Michele Pertile on 05/12/2018.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    var user : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonOutlet.layer.cornerRadius = 18
        buttonOutlet.clipsToBounds = true
        
        NetworkManager.getUserLoggedData { (user) in
            self.user = user
            
            self.nameOutlet.text = user.name
            self.surnameOutlet.text = user.surname
            if user.image != nil{
                NetworkManager.dowloadImageProfile(withURL: user.image, completion: { (image) in
                    self.imageOutlet.setImage(image, for: .normal)
                })
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBAction func buttonAction(_ sender: UIButton) {
     
        var currentName = nameOutlet.text
        var currentSurname = surnameOutlet.text
        
        
    }
    @IBOutlet weak var surnameOutlet: UITextField!
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var imageOutlet: UIButton!
    @IBAction func changeImage(_ sender: UIButton) {
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        NetworkManager.logOut()
        let storyboard = UIStoryboard(name: "WhiteStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        present(viewController, animated: true, completion: nil)
    }
    
}
