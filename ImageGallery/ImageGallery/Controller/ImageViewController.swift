//
//  ViewController.swift
//  ImageGallery
//
//  Created by Slayer on 1/4/21.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageCellIdentifier = "imageCell"
    var dataManager = DataManager()
    
    var imageData = Array<ImageModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        dataManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataManager.fetchImages()
    }
}

extension ImageViewController: UICollectionViewDataSource, DataManagerDelegate{
    func didUpdateData(_ dataManager: DataManager, images: Array<ImageModel>) {

        self.imageData = images
        
        DispatchQueue.main.async {
            if (self.collectionView.numberOfItems(inSection: 0) == 0){
                self.collectionView.reloadData()
            } else {
                self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
            }
        }
    }
    
    func didFailWithError(error: Error) {
        print("failed with error: \(error)")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.systemPurple
        return cell
    }
    
}

