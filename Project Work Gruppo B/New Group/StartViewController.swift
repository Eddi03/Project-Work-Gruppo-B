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

        let navBar = self.navigationController?.navigationBar
        navBar?.barTintColor = UIColor.white
        
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

    @IBOutlet weak var orLabel: UILabel! {
        didSet {
            orLabel.text = R.string.localizable.kOrLabel()
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

}
