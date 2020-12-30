//
//  AlbumView.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/28/20.
//

import SwiftUI

struct AlbumView: View {
    @EnvironmentObject private var viewModel: PhotoGalleryViewModel
    
    private let album: Album
    
    init(album: Album) {
        self.album = album
    }
    
    var body: some View {
        List(photosForAlbum()) { photo in
            if let thumbnailURL = URL(string: photo.thumbnailUrl) {
                NavigationLink(destination: PhotoView(photo: photo)) {
                    AsyncImage(url: thumbnailURL)
                }
            }
        }
        .navigationTitle("Album: \(album.title)")
    }
    
    private func photosForAlbum() -> [Photo] {
        return viewModel.photos.filter { photo -> Bool in
            return photo.albumId == album.id
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView(album: Album(userId: 1, id: 1, title: "Preview Album"))
    }
}
