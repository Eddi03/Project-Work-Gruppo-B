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
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressShowPassword))
        let secondLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(secondLongPressShowPassword))
        showPasswordButton.addGestureRecognizer(longGesture)
        showConfirmPasswordButton.addGestureRecognizer(secondLongGesture)
        
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
    
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var showConfirmPasswordButton: UIButton!
    
    @objc func longPressShowPassword(gesture: UILongPressGestureRecognizer){
        if showPasswordButton.isTouchInside {
            if gesture.state == UIGestureRecognizer.State.began {
                passwordField.isSecureTextEntry = false
                let image = UIImage.init(named: "Eye")
                showPasswordButton.setImage(image, for: .normal)
            }else {
                if gesture.state == UIGestureRecognizer.State.ended{
                    passwordField.isSecureTextEntry = true
                    let image = UIImage.init(named: "Eye Grey")
                    showPasswordButton.setImage(image, for: .normal)
                }
            }
        }
    }
    
    @objc func secondLongPressShowPassword(gesture: UILongPressGestureRecognizer){
        if showConfirmPasswordButton.isTouchInside {
            if gesture.state == UIGestureRecognizer.State.began {
                repeatPasswordField.isSecureTextEntry = false
                let image = UIImage.init(named: "Eye")
                showConfirmPasswordButton.setImage(image, for: .normal)
            }else {
                if gesture.state == UIGestureRecognizer.State.ended{
                    repeatPasswordField.isSecureTextEntry = true
                    let image = UIImage.init(named: "Eye Grey")
                    showConfirmPasswordButton.setImage(image, for: .normal)
                }
            }
        }
    }
    
    
   // if showConfirmPasswordButton.isTouchInside {
    //                if gesture.state == UIGestureRecognizer.State.began {
    //                    repeatPasswordField.isSecureTextEntry = false
    //                }else {
    //                    if gesture.state == UIGestureRecognizer.State.ended{
    //                        repeatPasswordField.isSecureTextEntry = true
    //                    }
    //                }
    //            }
    //
    
    @IBOutlet weak var navBarSignUpTitle: UINavigationItem!{
        didSet {
            navBarSignUpTitle.title = R.string.localizable.kNavBarSignUpTitle()
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
