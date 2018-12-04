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
        
        loginButton.layer.cornerRadius = 18
        loginButton.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
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
