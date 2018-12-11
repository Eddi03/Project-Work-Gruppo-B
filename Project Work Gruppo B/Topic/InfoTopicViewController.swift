//
//  InfoTopicViewController.swift
//  Project Work Gruppo B
//
//  Created by Eddi Raimondi on 11/12/2018.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class InfoTopicViewController: UIViewController {

    
    @IBOutlet weak var navBarTitleTopic: UINavigationItem!
    @IBOutlet weak var descriptionTitleTopic: UILabel!
    @IBOutlet weak var descriptionTopic: UILabel!
    var titleFromTopics: String = String ()
    
    @IBOutlet weak var deleteTopic: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deleteTopic.layer.cornerRadius = 18
        deleteTopic.clipsToBounds = true
        self.title = titleFromTopics
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
