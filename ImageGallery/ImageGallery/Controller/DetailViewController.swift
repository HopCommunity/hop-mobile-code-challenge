//
//  ViewController.swift
//  ImageGallery
//
//  Created by Slayer on 1/4/21.
//

import UIKit

class DetailViewController: UIViewController{
    
    var imageData: ImageModel = ImageModel()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleLabel.text = imageData.title
        let url = URL(string: imageData.url)
        
        DispatchQueue.global().async {
            
            // If image data present, display image
            if let data = try? Data(contentsOf: url! ){
                if let image = UIImage(data: data){
                    self.setImage(image)
                }
            } else {
                // If error, display default image
                if let image = UIImage(systemName: "questionmark.circle"){
                    self.setImage(image)
                }
            }
        }
    }
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setImage(_ image: UIImage){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
}
