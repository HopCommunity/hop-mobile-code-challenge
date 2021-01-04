//
//  ViewController.swift
//  ImageGallery
//
//  Created by Slayer on 1/4/21.
//

import UIKit

class ViewController: UIViewController {

    let imageManager = ImageManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageManager.fetchImages()
    }


}

