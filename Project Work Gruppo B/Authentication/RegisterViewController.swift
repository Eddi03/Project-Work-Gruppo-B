//
//  RegisterViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 28/11/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    var id : String!
    var email : String!
    var password : String!
    var repeatPassword : String!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var repeatPasswordField: UITextField!
    
    @IBAction func registerAction(_ sender: Any) {
        
        email = emailField.text
        password = passwordField.text
        repeatPassword = repeatPasswordField.text
        
        
        NetworkManager.signup(email: email, password: password){ (success) in
            if success{
                self.id = Auth.auth().currentUser?.uid
                
                self.performSegue(withIdentifier: R.segue.registerViewController.segueToSave, sender: self)
            }
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = (segue.destination as? UINavigationController)?.viewControllers[0] as? SaveViewController{
            destinationSegue.email = self.email
            destinationSegue.id = self.id
        }
    }
    
}
