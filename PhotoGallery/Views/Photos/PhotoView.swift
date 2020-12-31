//
//  PhotoView.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/29/20.
//

import SwiftUI

struct PhotoView: View {
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
    
    var body: some View {
        if let url = URL(string: photo.url) {
            AsyncImage(url: url)
                .navigationTitle("\(photo.title)")
        } else {
            Text("Something is wrong with this photo")
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(photo: Photo(albumId: 1, id: 1, title: "Photo", url: "", thumbnailUrl: ""))
    }
}
