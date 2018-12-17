//
//  StartViewController.swift
//  Project Work Gruppo B
//
//  Created by Michele Pertile on 04/12/2018.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 20
        loginButton.clipsToBounds = true
        
//        registerButton.layer.cornerRadius = 20
//        registerButton.backgroundColor = .clear
//        registerButton.layer.cornerRadius = 1
//        registerButton.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var titleAppLabel: UILabel! {
        didSet {
            titleAppLabel.text = R.string.localizable.kTitleApp()
        }
    }
    
    @IBOutlet weak var welcomeLabel: UILabel! {
        didSet {
            welcomeLabel.text = R.string.localizable.kWelcomeLabel()
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitle(R.string.localizable.kLoginButton(), for: .normal)
        }
    }

    @IBOutlet weak var registerButton: UIButton! {
        didSet {
            registerButton.setTitle(R.string.localizable.kSignUpButton(), for: .normal)
        }
    }
    
    var deviceName : String = UIDevice.current.name
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on this view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.welcomeLabel.text = R.string.localizable.kWelcomeLabel() + deviceName
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func toLoginAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: R.segue.startViewController.toLoginSegue, sender: self)
    }
    
    @IBAction func toRegisterAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: R.segue.startViewController.toRegisterSegue, sender: self)
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
