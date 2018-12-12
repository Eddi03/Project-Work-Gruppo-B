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
    var imageArray=[UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.backgroundColor=UIColor.white
        
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
        
        grabPhotos()
    }
    
    
    //MARK: CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1{
            return imageArray.count
        }
        if section == 3{
            return imageArray.count
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
        cell.img.image=imageArray[indexPath.item]
            return cell}
        if indexPath.section == 2{
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: LabelItemCell.kIdentifier, for: indexPath) as! LabelItemCell
            cell.text.text = "SCARTO"
            updateLabelSize(cell: cell)
            return cell
        }
        if indexPath.section == 3{
            let cell=myCollectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.kIdentifier, for: indexPath) as! PhotoItemCell
            cell.img.image=imageArray[indexPath.item]
            return cell}
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let vc=ImagePreview()
            vc.imgArray = self.imageArray
            vc.passedContentOffset = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc=ImagePreview()
            vc.imgArray = self.imageArray
            vc.passedContentOffset = indexPath
            self.navigationController?.pushViewController(vc, animated: true)
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myCollectionView.collectionViewLayout.invalidateLayout()
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
    //MARK: grab photos
    func grabPhotos(){
        imageArray = []
        
//        NetworkManager.dowloadImageProfile(withURL: "https://firebasestorage.googleapis.com/v0/b/project-work-gruppo-b.appspot.com/o/profileImages%2F3EB47AbzNIYufpUDy8wDO86IMSF2.jpg?alt=media&token=6d16e654-854a-4f1f-a4ab-6d10ad48ef2c", completion: { (image) in
//            self.imageArray.append(image!)
//            DispatchQueue.main.async {
//                self.myCollectionView.reloadData()
//            }
//        })

        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let imgManager=PHImageManager.default()
            
            let requestOptions=PHImageRequestOptions()
            requestOptions.isSynchronous=true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions=PHFetchOptions()
            fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            print(fetchResult)
            print(fetchResult.count)
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count{
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:500, height: 500),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("no photos.")
            }
            print("count: \(self.imageArray.count)")
            
            DispatchQueue.main.async {
                self.myCollectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationSegue = segue.destination as? AddPhotoViewController{
            destinationSegue.album = album
            destinationSegue.topic = topic
        }
    }
    
    
}


class PhotoItemCell: UICollectionViewCell {
    static var kIdentifier = "PhotoCollectionViewCell"
    
    @IBOutlet var img: UIImageView!{
        didSet{
            img.contentMode = .scaleAspectFill
            img.clipsToBounds=true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = self.bounds
    }
    
   
}
class LabelItemCell: UICollectionViewCell {
    static var kIdentifier = "LabelCollectionViewCell"
    
    @IBOutlet var text: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
}
