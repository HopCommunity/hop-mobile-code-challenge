//
//  ImageManager.swift
//  ImageGallery
//
//  Created by Slayer on 1/4/21.
//

import Foundation

protocol DataManagerDelegate{
    func didUpdateData(_ dataManager: DataManager, images: Array<ImageModel>)
    func didFailWithError(error: Error)
}

struct DataManager {
    let imageURL = "https://jsonplaceholder.typicode.com"
    
    var delegate: DataManagerDelegate?
    
    func fetchImages(){
        let urlString = "\(imageURL)/photos"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
        
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: parseOutput(data: response: error:))
            
            task.resume()
        }
    }
    
    func parseOutput(data: Data?, response: URLResponse?, error: Error?){
        if error != nil {
            print (error!)
        }

        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(Array<ImageModel>.self, from: data!)
            self.delegate?.didUpdateData(self, images: decodedData)
            
        } catch {
            print("error: \(error)")
        }
    }
}
