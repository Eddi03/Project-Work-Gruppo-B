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
    @IBOutlet weak var bentornatoLabel: UILabel!
    
    var deviceName : String = UIDevice.current.name
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on this view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.bentornatoLabel.text = "Bentornato, " + deviceName
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
