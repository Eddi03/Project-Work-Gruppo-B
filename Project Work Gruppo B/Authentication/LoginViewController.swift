//
//  LoginViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 28/11/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var email : String!
    var password : String!
    var iconClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonShowPassword.isHidden = true
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressShowPassword))
        buttonShowPassword.addGestureRecognizer(longGesture)
        buttonShowPassword.imageView?.tintColor = UIColor.gray
    }
    
    @IBOutlet weak var buttonShowPassword: UIButton!
    @IBAction func eyeAction(_ sender: Any) {
        buttonShowPassword.isHidden = false
    }
    
    @IBAction func eyeOffAction(_ sender: Any) {
        buttonShowPassword.isHidden = true
    }
    
    @IBOutlet var passwordField: UITextField! {
        didSet {
            passwordField.placeholder = R.string.localizable.kLoginPasswordField()
        }
    }
    
    @objc func longPressShowPassword(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            
            passwordField.isSecureTextEntry = false
            let img = UIImage(named: "Eye")
            buttonShowPassword.setImage(img, for: .normal)
            print("PREMENDO")
        
        }else{
            
            if gesture.state == UIGestureRecognizer.State.ended {
                passwordField.isSecureTextEntry = true
                
                //BOTTONE NON PREMUTO
                let origImage = UIImage(named: "Eye Gray")
                buttonShowPassword.setImage(origImage, for: .normal)
                print("PREMENDO")
            }
        }
    }
    
    @IBAction func showPasswordAction(_ sender: Any) {

    }
    
    @IBOutlet weak var orLabel: UILabel!{
        didSet {
            orLabel.text = R.string.localizable.kOrLabel()
        }
    }
    
    @IBOutlet weak var navBarBack: UINavigationItem! {
        didSet {
            navBarBack.title = R.string.localizable.kNavBarBackToHome()
        }
    }
    
    @IBOutlet weak var navbarTitle: UINavigationItem! {
        didSet {
            navbarTitle.title = R.string.localizable.kLoginButton()
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitle(R.string.localizable.kLoginButton(), for: .normal)
        }
    }
    
    @IBOutlet var emailField: UITextField! {
        didSet {
            emailField.placeholder = R.string.localizable.kLoginEmailTextField()
        }
    }
    
    @IBOutlet weak var resetPasswordButton: UIButton! {
        didSet {
            resetPasswordButton.setTitle(R.string.localizable.kResetPasswordButton(), for: .normal)
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        let spinner = UIViewController.displaySpinner(onView: self.view)
        email = emailField.text
        password = passwordField.text
        
        NetworkManager.login(email: email, password: password){ (success) in
            UIViewController.removeSpinner(spinner: spinner)
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
