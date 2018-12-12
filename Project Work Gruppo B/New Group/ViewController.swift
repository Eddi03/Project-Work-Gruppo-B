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
    var admin: Bool!
    
    override func viewDidAppear(_ animated: Bool) {
        let spinner = UIViewController.displaySpinner(onView: self.view)
        
        if Auth.auth().currentUser != nil {
            
            NetworkManager.checkIfDataIsFilled { (success) in
                UIViewController.removeSpinner(spinner: spinner)
                if success {
                    NetworkManager.getUserLogged { (success) in
                        if success {
                            
                            guard let id = NetworkManager.getMyID(), let isSupervisor = User.getUserById(withid: id)?.supervisor else {
                                return
                            }
                            
                            self.admin = isSupervisor
                            self.performSegue(withIdentifier: R.segue.viewController.segueToMain, sender: nil)
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = (segue.destination as? UINavigationController)?.viewControllers[0] as? TopicListViewController{
            destinationSegue.admin = self.admin
        }
    }
}
