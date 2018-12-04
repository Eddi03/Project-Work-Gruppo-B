//
//  OptionsViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 03/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

    var supervisor : Bool = false
    
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
                self.supervisor = User.getUser(withid: NetworkManager.getMyID() ?? "")?.supervisor ?? false
                //guard let isSupervisor = User.getUser(withid: NetworkManager.getMyID() ?? "")?.supervisor else { return }
                print("GGGGGGGGGGGGG", self.supervisor)
                if self.supervisor{
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
