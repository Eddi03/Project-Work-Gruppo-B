//
//  ViewController.swift
//  Project Work Gruppo B
//
//  Created by Eddi Raimondi on 28/11/2018.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: R.segue.viewController.segueToOptions, sender: self)
        }
        else{
            self.performSegue(withIdentifier: R.segue.viewController.segueToLogin, sender: self)
        }
    }


}

