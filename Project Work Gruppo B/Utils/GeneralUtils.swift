//
//  GeneralUtils.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 28/11/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class GeneralUtils: NSObject {
    
    static let share = GeneralUtils()
    
    
    func alertBuilder(title: String?, message: String?, style : UIAlertController.Style = .alert, withAction action : Bool = true, actionTitle : [String] = ["ok"], closeAction: @escaping (Int) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        if action {
            for (index, buttonTitle) in actionTitle.enumerated() {
                
                let button = UIAlertAction(title: buttonTitle, style: .default, handler: { action in
                    closeAction(index)
                })
                
                alert.addAction(button)
            }
        }
        
        if let stringColor = GenericSettings.getObject()?.customPrimaryColor {
            alert.view.tintColor = UIColor.red
        }
        
        
        
        return alert
    }
    
    func alertError(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        return alert
    }
    
    
    func reloadGenericViewController(storyboardName : String, controllerIdentifier: String) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let setViewController = mainStoryboard.instantiateViewController(withIdentifier: controllerIdentifier)
        let rootViewController = UIApplication.shared.windows.last?.rootViewController
        rootViewController?.present(setViewController, animated: true, completion: nil)
    }
    
    
}
