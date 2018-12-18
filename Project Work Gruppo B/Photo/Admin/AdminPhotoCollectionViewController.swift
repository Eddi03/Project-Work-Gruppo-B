//
//  ShowAlbumViewController.swift
//  Project Work Gruppo B
//
//  Created by Jason Bourne on 04/12/18.
//  Copyright © 2018 Eddi. All rights reserved.
//

import UIKit
import Photos
import SKPhotoBrowser

class AdminPhotoCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate {
    
    
    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet var discardImagesOutlet: UIBarButtonItem!
    var topic : Topic!
    var album : Album!
    var images=[Image]()
    var imagesDiscarded=[Image]()
    var imagesToBrowser = [SKPhotoProtocol]()
    var scartedImage : Image!
    var imagesToDiscard = [String]()
    var discarding : Bool = false
    private var barButtonItem : UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        barButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        
        myCollectionView.delegate=self
        myCollectionView.dataSource=self
        myCollectionView.allowsMultipleSelection = true
        
    }
    
    @IBAction func albumDetailsAction(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.adminPhotoCollectionViewController.segueToAdminAlbumDetails, sender: self)
    }
    @objc func saveAction(){
        
        for img in imagesToDiscard{
            
            DispatchQueue.main.async {
                let photo = Photo.getPhotoById(id: img)
                photo?.changeData(discarded: true)
                NetworkManager.addPhoto(topic: self.topic, album: self.album, photo: photo!, updateTopic: false, updateAlbum: false) { (success) in
                    
                    self.setupImages()
                }
                
            }
        }
        self.navigationItem.rightBarButtonItem = nil
        discardImagesOutlet.tintColor = UIColor.green
        imagesToDiscard = []
    }
    
    
    
    @IBAction func discardImagesAction(_ sender: Any) {
        if discarding{
            discarding = false
            discardImagesOutlet.tintColor = UIColor.green
            imagesToDiscard = []
            self.navigationItem.rightBarButtonItem = nil
        }
        else{
            discarding = true
            discardImagesOutlet.tintColor = UIColor.blue
            
            self.navigationItem.rightBarButtonItem = barButtonItem
        }
    }
    
    
    @IBAction func archiviaAction(_ sender: Any) {
        //lo fa solo se prima l'operatore ha messo completed a true
        if album.completed {
            
            let alert = UIAlertController(title: "Album completo", message: "Vuoi segnare l'album come completo?", preferredStyle: .alert)
            let actionNo = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
            alert.addAction(actionNo)
            alert.addAction(UIAlertAction(title: "Si", style: .default, handler: { action in
                NetworkManager.deleteAlbum(topic: self.topic, idAlbum: self.album.id, completion: {success in
                    if success {
                        print("eliminato il completed album")
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                self.album.changeData(completed: false)
                NetworkManager.addAlbum(topic: self.topic, album: self.album, bool: false, completion: {success in
                    if success {
                        print("modificato il completed album")
                    }
                })
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func convertImageToBrowser(){
        self.imagesToBrowser = []
        for image in self.images{
            let imageToBrowser = SKPhoto.photoWithImage(UIImage(data: image.image!)!)
            imageToBrowser.caption = image.info
            self.imagesToBrowser.append(imageToBrowser)
        }
    }
    func setupImages(){
        NetworkManager.getPhotos(completion: {   success in
            if success {
                let photos = Photo.getPhotoFromAlbum(idCurrentAlbum: self.album.id, discarded: false)
                if !(photos.isEmpty){
                    DispatchQueue.main.async {
                        for i in photos{
                            
                            NetworkManager.dowloadImage(withURL: i.image!, completion: { (image) in
                                let img = Image(image: image?.pngData(), info: i.info, discarded: false, id: i.id)
                                img.save()
                                self.images = Image.getImageFromAlbum(idCurrentAlbum: self.album.id, discarded: false)
                                self.convertImageToBrowser()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myCollectionView.reloadData()
        setupImages()
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
            let cell=myCollectionView.dequeueReusableCell(withReuseIdentifier: AdminPhotoItemCell.kIdentifier, for: indexPath) as! AdminPhotoItemCell
            cell.img.image=UIImage(data: images[indexPath.item].image!)
            if !discarding{
                cell.checkedImage.isHidden = true
            }
            else{
                cell.checkedImage.isHidden = false
                if imagesToDiscard.contains(images[indexPath.item].id) {
                    cell.isSelected=true
                    myCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
                    cell.checkedImage.image = (UIImage(named: "Checked"))
                }
                else{
                    cell.isSelected=false
                    cell.checkedImage.image = (UIImage(named: "UnChecked"))
                }}
            return cell}
        if indexPath.section == 2{
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: LabelItemCell.kIdentifier, for: indexPath) as! LabelItemCell
            cell.text.text = "SCARTO"
            updateLabelSize(cell: cell)
            return cell
        }
        if indexPath.section == 3{
            let cell=myCollectionView.dequeueReusableCell(withReuseIdentifier: AdminPhotoItemCell.kIdentifier, for: indexPath) as! AdminPhotoItemCell
            cell.img.image=UIImage(data: imagesDiscarded[indexPath.item].image!)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        //add the selected cell contents to _selectedCells arr when cell is selected
        if indexPath.section == 1 && discarding{
            imagesToDiscard.append(images[indexPath.item].id)
            debugPrint(imagesToDiscard[0])
            collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        //remove the selected cell contents from _selectedCells arr when cell is De-Selected
        if indexPath.section == 1 && discarding{
            if let position = imagesToDiscard.firstIndex(of:images[indexPath.item].id){
                imagesToDiscard.remove(at: position)
            }
        }
        myCollectionView.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = myCollectionView.frame.width
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
    }
    
    
    
}
