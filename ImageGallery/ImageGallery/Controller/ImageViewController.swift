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
    let imageManager = ImageManager()
    let numberOfCells = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageManager.fetchImages()
        collectionView.dataSource = self
    }
}

extension ImageViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.systemPurple
        return cell
    }
    
}

