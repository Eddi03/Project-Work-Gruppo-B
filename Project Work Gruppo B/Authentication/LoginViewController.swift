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
        
        loginButton.layer.cornerRadius = 18
        loginButton.clipsToBounds = true
        navbarTitle.title = "Accedi"
        
        // Do any additional setup after loading the view.
    }
    var email : String!
    var password : String!
    
    @IBOutlet weak var navbarTitle: UINavigationItem!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBAction func loginAction(_ sender: Any) {
    
        
        email = emailField.text
        password = passwordField.text
        NetworkManager.login(email: email, password: password){ (success) in
            if success{
                self.dismiss(animated: true, completion:{
                    self.performSegue(withIdentifier: R.segue.loginViewController.segueToOptions, sender: self)})
            }
        }
    }
    
    @IBAction func resetP(_ sender: Any) {
        resetPassword()
    }
    
    
    func resetPassword(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Reset Password", message: "Immetti la tua email", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "email"
        }
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            
            //firebase
            NetworkManager.resetPassword(email: (textField?.text ?? ""))
            let alert2 = UIAlertController(title: "Reset Password", message: "è stata mandata una mail per resettare la password alla mail \(String(describing: textField?.text))", preferredStyle: .alert)
            let actionName = UIAlertAction(title: "Letto", style: .cancel, handler: nil)
            alert2.addAction(actionName)
            self.present(alert2, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
}
