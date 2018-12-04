//
//  OptionsViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //NetworkManager.logOut()
        //self.performSegue(withIdentifier: "segueToLogin", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.performSegue(withIdentifier: R.segue.optionsViewController.segueToOperator, sender: self)
       
        //da aggiungere admin/operator
        NetworkManager.getUserLogged { (success) in
            if success {
                
                guard let id = NetworkManager.getMyID(), let isSupervisor = User.getUser(withid: id)?.Supervisor else {
                    return
                }
               
                if isSupervisor{
                    self.performSegue(withIdentifier: "segueToAdmin", sender: nil)
                } else {
                    self.performSegue(withIdentifier: "segueToOperator", sender: nil)
                }
            }
        }

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
