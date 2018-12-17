//
//  AddPhotoViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit

class AddPhotoViewController: UIViewController {
    private var pickerController:UIImagePickerController?

    @IBOutlet var textOutlet: UITextField!
    @IBOutlet var imageOutlet: UIButton!
    var topic : Topic!
    var album : Album!
    var imagePhoto : Data?
    var scarted : Image?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let scartedImage = scarted{
            imageOutlet.setImage(UIImage(data: scartedImage.image!), for: .normal)
            textOutlet.text = scartedImage.info
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func saveAction(_ sender: Any) {
        
        guard imagePhoto != nil else{
            debugPrint("error")
            return
        }
        
        var id = UUID().uuidString
        if let scartedImage = scarted{
            id = scartedImage.id
        }
        NetworkManager.uploadPhoto(withData: imagePhoto!, topicId: topic.id, albumId: album.id, photoId: id) { (URLImage) in
            let photo = Photo(image: URLImage, info: self.textOutlet.text ?? "", discarded: false,id: id)
            NetworkManager.addPhoto(topic: self.topic, album: self.album, photo: photo, bool: false, completion: { (success) in
                self.navigationController?.popViewController(animated: true)
            })

            }
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
}

extension AddPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            debugPrint("No image found")
            return
        }
        
        let img = checkImageSizeAndResize(image: image)
        imageOutlet.setImage(img, for: .normal)
        imagePhoto = img.pngData()
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
