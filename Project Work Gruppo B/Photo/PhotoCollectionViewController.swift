//
//  ShowAlbumViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import Photos

class PhotoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    @IBAction func addPhotoAction(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.photoCollectionViewController.segueToAddPhoto, sender: self)
    }
    
    var topic : Topic!
    var album : Album!
    var images=[Image]()
    var imagesDiscarded=[Image]()
    var scartedImage : Image!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.backgroundColor=UIColor.white
        
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
        
    }
    
    @IBAction func albumDetailsAction(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.photoCollectionViewController.segueToAlbumDetails, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myCollectionView.reloadData()
        NetworkManager.getPhotos(completion: {   success in
            if success {
                let photos = Photo.getPhotoFromAlbum(idCurrentAlbum: self.album.id, discarded: false)
                debugPrint("ricchi")
                if !(photos.isEmpty){
                    DispatchQueue.main.async {
                        for i in photos{
                            
                            NetworkManager.dowloadImage(withURL: i.image!, completion: { (image) in
                                let img = Image(image: image?.pngData(), info: i.info, discarded: false, id: i.id)
                                img.save()
                                
                                self.images = Image.getImageFromAlbum(idCurrentAlbum: self.album.id, discarded: false)
                                self.myCollectionView.reloadData()
                            })
                        }
                    }
                }
                let discardedPhotos = Photo.getPhotoFromAlbum(idCurrentAlbum: self.album.id, discarded: true)
                debugPrint(discardedPhotos.count)
                if !(discardedPhotos.isEmpty){
                    DispatchQueue.main.async {
                        for i in discardedPhotos{
                            
                            NetworkManager.dowloadImage(withURL: i.image!, completion: { (image) in
                                let img = Image(image: image?.pngData(), info: i.info,discarded: true, id: i.id)
                                img.save()
                                self.imagesDiscarded = Image.getImageFromAlbum(idCurrentAlbum: self.album.id, discarded: true)
                                self.myCollectionView.reloadData()
                            })
                        }
                    }
                }
            }else{
                GeneralUtils.share.alertError(title: "errore", message: "")
            }
        })
        

    }
    
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            return images.count
        }
        if section == 3{
            return imagesDiscarded.count
        }
        if section == 2 && imagesDiscarded.isEmpty{
            debugPrint("secchetion",imagesDiscarded.count)
            return 0
        }
        return 1
    }
    
    func updateLabelSize(cell : LabelItemCell!){
        let maxSize = CGSize(width: myCollectionView.frame.width, height: 40)
        let size = cell.text.sizeThatFits(maxSize)
        cell.text.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: LabelItemCell.kIdentifier, for: indexPath) as! LabelItemCell
            cell.text.text = "NORMALE O QUASI"
            updateLabelSize(cell: cell)
            return cell
        }
        if indexPath.section == 1{
        let cell=myCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.kIdentifier, for: indexPath) as! PhotoItemCell
            cell.img.image=UIImage(data: images[indexPath.item].image!)
            return cell}
        if indexPath.section == 2{
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: LabelItemCell.kIdentifier, for: indexPath) as! LabelItemCell
            cell.text.text = "SCARTO"
            updateLabelSize(cell: cell)
            return cell
        }
        if indexPath.section == 3{
            let cell=myCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.kIdentifier, for: indexPath) as! PhotoItemCell
            cell.img.image=UIImage(data: imagesDiscarded[indexPath.item].image!)
            return cell}
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let vc=ImagePreview()
            vc.imgArray = self.images
            vc.passedContentOffset = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            scartedImage = imagesDiscarded[indexPath.item]
            self.performSegue(withIdentifier: R.segue.photoCollectionViewController.segueToAddPhoto, sender: self)
        default:
            return
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = myCollectionView.frame.width
        //        if UIDevice.current.orientation.isPortrait {
        //            return CGSize(width: width/4 - 1, height: width/4 - 1)
        //        } else {
        //            return CGSize(width: width/6 - 1, height: width/6 - 1)
        //        }
//        if DeviceInfo.Orientation.isPortrait {
//            return CGSize(width: width/3 - 1, height: width/3 - 1)
//        } else {
        switch indexPath.section {
        case 0:
            return CGSize(width: width-1, height: 40)
        case 1:
            return CGSize(width: width/3 - 1, height: width/3 - 1)
        case 2:
            return CGSize(width: width-1, height: 40)
        case 3:
            return CGSize(width: width/3 - 1, height: width/3 - 1)
        default:
            return CGSize()
        }
        
        //}
    }
    
    override func viewDidLayoutSubviews() {
        myCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? AddPhotoViewController{
            destinationSegue.album = album
            destinationSegue.topic = topic
            if let scarted = scartedImage{
                destinationSegue.scarted = scarted
            }
        }
    }
    
    
}


//
//struct DeviceInfo {
//    struct Orientation {
//        // indicate current device is in the LandScape orientation
//        static var isLandscape: Bool {
//            get {
//                return UIDevice.current.orientation.isValidInterfaceOrientation
//                    ? UIDevice.current.orientation.isLandscape
//                    : UIApplication.shared.statusBarOrientation.isLandscape
//            }
//        }
//        // indicate current device is in the Portrait orientation
//        static var isPortrait: Bool {
//            get {
//                return UIDevice.current.orientation.isValidInterfaceOrientation
//                    ? UIDevice.current.orientation.isPortrait
//                    : UIApplication.shared.statusBarOrientation.isPortrait
//            }
//        }
//    }
//}
