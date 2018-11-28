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
