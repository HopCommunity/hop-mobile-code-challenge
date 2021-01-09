//
//  LandingViewController.swift
//  ImageGallery
//
//  Created by Slayer on 1/7/21.
//

import UIKit


class LandingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var loadingIcon = UIActivityIndicatorView(style: .large)
    
    let imageCellIdentifier = "imageCell"
    var dataManager = DataManager()
    
    var imageData = Array<ImageModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataManager.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataManager.fetchImages()
    }
}

extension LandingViewController: DataManagerDelegate{
    func didStartDataLoad() {
        // Add loading icon
        view.addSubview(loadingIcon)
        
        // Center loading icon
        loadingIcon.translatesAutoresizingMaskIntoConstraints = false
        loadingIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIcon.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loadingIcon.startAnimating()
    }
    
    // Reload collectionView upon data update
    func didUpdateData(_ dataManager: DataManager, images: Array<ImageModel>) {
        // Stop animating loading icon, request is over
        DispatchQueue.main.async {
            self.loadingIcon.stopAnimating()
            self.loadingIcon.removeFromSuperview()
        }
        
        self.imageData = images
        
        DispatchQueue.main.async {
            // Reload collectionView items
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
}

extension LandingViewController: UICollectionViewDataSource{
    
    // Set image for collection view cell
    func setCollectionViewCellImage(_ cellImage: UIImage, forCell cell: UICollectionViewCell){
        
        DispatchQueue.main.async {
            let imageView = UIImageView(frame: cell.contentView.frame)
            
            // Creating circular image frame
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            
            // Set image
            imageView.image = cellImage
         
            cell.contentView.addSubview(imageView)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellIdentifier, for: indexPath)
        
        let cellData = imageData[indexPath.row]
        let url = URL(string: cellData.thumbnailUrl)

        DispatchQueue.global().async {
            
            // If image data present, display image
            if let data = try? Data(contentsOf: url! ){
                    let cellImage = UIImage(data: data)
                    self.setCollectionViewCellImage(cellImage!, forCell: cell)
            } else {
                // If error, display default image
                    let cellImage = UIImage(systemName: "questionmark.circle")
                    self.setCollectionViewCellImage(cellImage!, forCell: cell)
            }
        }
        return cell
    }
    
}

extension LandingViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellData: ImageModel = imageData[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let detailVC: DetailViewController = storyboard.instantiateViewController(identifier: "DetailViewController")
        detailVC.imageData = cellData
        
        showDetailViewController(detailVC, sender: self)
    }
}

