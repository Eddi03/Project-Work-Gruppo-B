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
        buttonOutlet.layer.cornerRadius = 18
        buttonOutlet.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var navBarSignUpTitle: UINavigationItem!{
        didSet {
            navBarSignUpTitle.title = R.string.localizable.kNavBarSignUpTitle()
        }
    }
    var email : String!
    var password : String!
    var repeatPassword : String!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var repeatPasswordField: UITextField!{
        didSet {
            repeatPasswordField.placeholder = R.string.localizable.kSignUpConfirmPasswordTextField()
        }
    }
    @IBOutlet weak var buttonOutlet: UIButton!{
        didSet{
            buttonOutlet.setTitle(R.string.localizable.kSignUpNextButton(), for: .normal)
        }
    }

    
    @IBAction func registerAction(_ sender: Any) {
        
        let spinner = UIViewController.displaySpinner(onView: self.view)
        
        email = emailField.text
        password = passwordField.text
        repeatPassword = repeatPasswordField.text
        
        
        NetworkManager.signup(email: email, password: password){ (success) in
            UIViewController.removeSpinner(spinner: spinner)
            if success{
                self.performSegue(withIdentifier: R.segue.registerViewController.segueToAdditionalData, sender: self)
            }
        }
    }
 }
