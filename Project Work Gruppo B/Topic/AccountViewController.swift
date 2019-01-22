//
//  AccountViewController.swift
//  Project Work Gruppo B
//
//  Created by Michele Pertile on 05/12/2018.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {

    @IBOutlet weak var navBarLogout: UIBarButtonItem! {
        didSet {
            navBarLogout.title = R.string.localizable.kNavBarAccountLogout()
        }
    }
    
    @IBOutlet weak var nameTextFieldOutlet: kTextFiledPlaceHolder!
    
    var user : User!
    private var pickerController:UIImagePickerController?
    var URLImage : String?
    var imageUser : Data?
    var email : String! = Auth.auth().currentUser?.email
    var id :String! = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //let spinner = UIViewController.displaySpinner(onView: self.view)
        
        self.imageOutlet.layer.cornerRadius = self.imageOutlet.frame.size.width / 2;
        self.imageOutlet.clipsToBounds = true;
        
        NetworkManager.getUserLoggedData { (user) in
            self.user = user
            
            self.nameOutlet.text = user.name
            self.surnameOutlet.text = user.surname
            //UIViewController.removeSpinner(spinner: spinner)
            
            if user.image != nil{
                
                NetworkManager.dowloadImage(withURL: user.image!, completion: { (image) in
                    self.imageOutlet.setImage(image, for: .normal)
                    
                    //UIViewController.removeSpinner(spinner: spinner)

                })
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var buttonOutlet: UIButton! {
        didSet {
            buttonOutlet.setTitle(R.string.localizable.kAccountSaveButton(), for: .normal)
        }
    }
    
    
    @IBOutlet weak var surnameOutlet: UITextField!
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var imageOutlet: UIButton!
    @IBAction func changeImage(_ sender: UIButton) {
        
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

    @IBAction func buttonAction(_ sender: UIButton) {
        
        let currentName = nameOutlet.text
        let currentSurname = surnameOutlet.text
        
        if currentName != "" && currentSurname != ""
        {
            
            guard currentName != "" else{
                debugPrint("error")
                return
            }
            guard currentSurname != "" else{
                debugPrint("error")
                return
            }
        }
        
        URLImage = user.image
        print(imageUser)
 
        if  imageUser != nil {
        
            NetworkManager.uploadImageProfile(withData: imageUser!, forUserID: id) { (URLImage) in
                print(URLImage)
                self.URLImage = URLImage
                let pippo = User(email: self.user.email, name: currentName, surname: currentSurname, id: self.user.id, image: URLImage, supervisor: self.user.supervisor)
                
                NetworkManager.addUser(user: pippo, completion: { (success) in
                    self.dismiss(animated: true, completion: {
                        
                    })
                })
            }
            
        }else{
            let pippo = User(email: self.user.email, name: currentName, surname: currentSurname, id: self.user.id, image: URLImage, supervisor: self.user.supervisor)
            
            
            NetworkManager.addUser(user: pippo, completion: { (success) in
                self.dismiss(animated: true, completion: {
                    
                })
            })
        }
        
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        NetworkManager.logOut()
        let storyboard = UIStoryboard(name: "WhiteStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        present(viewController, animated: true, completion: nil)
    }
    
}

extension AccountViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
