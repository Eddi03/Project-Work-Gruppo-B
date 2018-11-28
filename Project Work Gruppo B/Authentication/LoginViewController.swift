//
//  LoginViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 28/11/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    var email : String!
    var password : String!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBAction func loginAction(_ sender: Any) {
        
        email = emailField.text
        password = passwordField.text
        NetworkManager.login(email: email, password: password){ (success) in
            if success{
                self.dismiss(animated: true, completion:{
                    self.performSegue(withIdentifier: R.segue.loginViewController.segueToHome.identifier, sender: self)})
            }
        }
    }
}
