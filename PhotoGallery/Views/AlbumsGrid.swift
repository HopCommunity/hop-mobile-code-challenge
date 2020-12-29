//
//  AlbumsGrid.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/28/20.
//

import SwiftUI

struct AlbumsGrid: View {
    private let albums: [Album]
    private let photos: [Photo]
    
    init(albums: [Album], photos: [Photo]) {
        self.albums = albums
        self.photos = photos
    }
    
    var body: some View {
        ScrollView {
            grid()
        }
    }
    
    private func grid() -> some View {
        let numberOfRows = (albums.count / 2) + (albums.count % 2)
        
        return VStack(alignment: .leading) {
            ForEach(0..<numberOfRows, id: \.self) { rowIndex in
                HStack {
                    if let url = getFirstPhotoThumbnailURL(albumId: albums[rowIndex*2].id) {
                        NavigationLink(destination: AlbumView()) {
                            VStack {
                                Text("\(albums[rowIndex].title)")
                                AsyncImage(url: url)
                            }
                        }
                    }
                    if let url = getFirstPhotoThumbnailURL(albumId: albums[rowIndex*2+1].id) {
                        NavigationLink(destination: AlbumView()) {
                            VStack {
                                Text("\(albums[rowIndex].title)")
                                AsyncImage(url: url)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func getFirstPhotoThumbnailURL(albumId: Int) -> URL? {
        let photo = photos.first { $0.albumId == albumId }
        guard let thumbnailURL = photo?.thumbnailUrl else { return nil }
        guard let url = URL(string: thumbnailURL) else { return nil }
        return url
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsGrid(albums: [], photos: [])
    }
}
