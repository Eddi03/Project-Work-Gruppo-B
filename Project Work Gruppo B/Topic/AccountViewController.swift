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
        
        self.imageOutlet.layer.cornerRadius = self.imageOutlet.frame.size.width / 2;
        self.imageOutlet.clipsToBounds = true;
        
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
    
       
        let currentName = nameOutlet.text
        let currentSurname = surnameOutlet.text
        
        let pippo = User(email: user.email, name: currentName, surname: currentSurname, id: user.id, image: user.image, supervisor: user.supervisor)
    
   
        NetworkManager.addUser(user: pippo, completion: { (success) in
            self.dismiss(animated: true, completion: {
                
            })
        })
    
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
