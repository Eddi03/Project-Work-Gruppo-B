//
//  SaveViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 28/11/18.
//  Copyright © 2018 Eddi. All rights reserved.
//


import UIKit
import FirebaseAuth

class SaveViewController: UIViewController {
    
    private var pickerController:UIImagePickerController?
    
    @IBOutlet weak var navBarTitleSignUp: UINavigationItem!{
        didSet{
            navBarTitleSignUp.title = R.string.localizable.kNavBarFinishSignUpTitle()
        }
    }
    
    @IBOutlet weak var registerButton: UIButton!{
        didSet {
            registerButton.setTitle(R.string.localizable.kSignUpButton(), for: .normal)
        }
    }
    
    @IBOutlet var imageOutlet: UIButton!
    @IBOutlet var emailOutlet: UITextField!
    
    @IBOutlet var nameOutlet: UITextField!{
        didSet{
            nameOutlet.placeholder = R.string.localizable.kFinishSignUpName()
        }
    }
    
    @IBOutlet weak var adminLabel: UILabel!{
        didSet {
            adminLabel.text = R.string.localizable.kSwitchAdmin()
        }
    }
    
    @IBOutlet var surnameOutlet: UITextField!{
        didSet{
            surnameOutlet.placeholder = R.string.localizable.kFinischSignUpSurname()
        }
    }
    
    @IBOutlet var supervisorOutlet: UISwitch!
    
    var imageUser : Data?
    var email : String! = Auth.auth().currentUser?.email
    var id :String! = Auth.auth().currentUser?.uid
    var URLImage : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = R.string.localizable.kNavBarFinishSignUpTitle()
        self.navBarTitleSignUp.title = R.string.localizable.kNavBarFinishSignUpTitle()
        if let name = Auth.auth().currentUser?.displayName{
            NetworkManager.getFacebookData { (data) in
                self.nameOutlet.text = data["first_name"] as? String
                self.surnameOutlet.text = data["last_name"] as? String
            }
            
        }
        emailOutlet.text = email
        self.imageOutlet.layer.cornerRadius = self.imageOutlet.frame.size.width / 2;
        self.imageOutlet.clipsToBounds = true;
    }
    
    @IBAction func addImageAction(_ sender: Any) {
        
        self.pickerController = UIImagePickerController()
        self.pickerController!.delegate = self
        self.pickerController!.allowsEditing = true
        let alert = UIAlertController(title: nil, message: "Foto profilo", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        #if !targetEnvironment(simulator)
        let photo = UIAlertAction(title: "Scatta foto", style: .default) { action in
            self.pickerController!.sourceType = .camera
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        
        alert.addAction(photo)
        #endif
        
        let camera = UIAlertAction(title: "Carica foto", style: .default) { alert in
            self.pickerController!.sourceType = .photoLibrary
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        
        alert.addAction(camera)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        let name = nameOutlet.text
        let surname = surnameOutlet.text
        let supervisor = supervisorOutlet.isOn
        
        if name != "" && surname != "" {
            
            guard name != "" else{
                debugPrint("error")
                return
            }
            
            guard surname != "" else{
                debugPrint("error")
                return
            }
            
            if let image = imageUser{
                NetworkManager.uploadImageProfile(withData: image, forUserID: id) { (URLImage) in
                    self.URLImage = URLImage
                    let user = User(email: self.email, name: name, surname: surname, id: self.id, image: URLImage,supervisor: supervisor)
                    user.save()
                    
                    NetworkManager.addUser(user: user, completion: { (success) in
                        self.performSegue(withIdentifier: "segueToOptions", sender: self)
                    })
                }
            }
            else{
                
                let user = User(email: email, name: name, surname: surname, id: id, image: URLImage,supervisor:supervisor)
                
                NetworkManager.addUser(user: user, completion: { (success) in
                    self.performSegue(withIdentifier: R.segue.saveViewController.segueToOptions, sender: self)
                })
            }
        }
        else{
            self.present(GeneralUtils.share.alertError(title: "Attenzione", message: "uno o più campi sono vuoti"), animated: true, completion: nil)
        }
    }
}

extension SaveViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            debugPrint("No image found")
            return
        }
        
        let img = checkImageSizeAndResize(image: image)
        imageOutlet.setImage(img, for: .normal)
        imageUser = img.pngData()
        self.dismiss(animated: true, completion: nil)
    }
    
    private func checkImageSizeAndResize(image : UIImage) -> UIImage {
        
        let imageSize: Int = image.pngData()!.count
        let imageDimension = Double(imageSize) / 1024.0 / 1024.0
        print("size of image in MB: ", imageDimension)
        
        if imageDimension > 1 {
            
            let img = image.resized(withPercentage: 0.5) ?? UIImage()
            return checkImageSizeAndResize(image: img)
        }
        return image
    }
}
