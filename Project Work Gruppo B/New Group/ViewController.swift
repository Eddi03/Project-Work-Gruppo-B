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
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            
            NetworkManager.checkIfDataIsFilled { (success) in
                if success {
                    NetworkManager.getUserLogged { (success) in
                        if success {
                            
                            guard let id = NetworkManager.getMyID(), let isSupervisor = User.getUser(withid: id)?.Supervisor else {
                                return
                            }
                            
                            if isSupervisor{
                                self.performSegue(withIdentifier: R.segue.viewController.segueToAdmin, sender: nil)
                            } else {
                                self.performSegue(withIdentifier: R.segue.viewController.segueToOperator, sender: nil)
                            }
                        }
                    }
                }
                else{
                    
                    let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier: "SaveViewController") as! SaveViewController
                    self.present(viewController, animated: true, completion: nil)

                }
            }
        }
        else{
            self.performSegue(withIdentifier: R.segue.viewController.segueToLogin, sender: self)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let sv = UIViewController.displaySpinner(onView: self.view)
    }

}

