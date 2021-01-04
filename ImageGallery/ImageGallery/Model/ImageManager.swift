//
//  ImageManager.swift
//  ImageGallery
//
//  Created by Slayer on 1/4/21.
//

import Foundation

struct ImageManager {
    let imageURL = "https://jsonplaceholder.typicode.com"
    
    func fetchImages(){
        let urlString = "\(imageURL)/photos"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString) {
        
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url, completionHandler: handleTask(data: response: error:))
            
            task.resume()
        }
    }
    
    func handleTask(data: Data?, response: URLResponse?, error: Error?){
        if error != nil {
            print (error!)
        }
        
        if let safeData = data {
            let dataString = String(data:safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
