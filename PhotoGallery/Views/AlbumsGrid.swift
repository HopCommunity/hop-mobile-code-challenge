//
//  AlbumsGrid.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/28/20.
//

import SwiftUI

struct AlbumsGrid: View {
    @EnvironmentObject private var viewModel: PhotoGalleryViewModel
    
    var body: some View {
        ScrollView {
            grid()
        }
    }
    
    private func grid() -> some View {
        let numberOfRows = (viewModel.albums.count / 2) + (viewModel.albums.count % 2)
        
        return VStack(alignment: .leading) {
            ForEach(0..<numberOfRows, id: \.self) { rowIndex in
                HStack {
                    if let url = getFirstPhotoThumbnailURL(albumId: viewModel.albums[rowIndex*2].id) {
                        NavigationLink(destination: AlbumView()) {
                            VStack {
                                Text("\(viewModel.albums[rowIndex].title)")
                                AsyncImage(url: url)
                            }
                        }
                    }
                    if let url = getFirstPhotoThumbnailURL(albumId: viewModel.albums[rowIndex*2+1].id) {
                        NavigationLink(destination: AlbumView()) {
                            VStack {
                                Text("\(viewModel.albums[rowIndex].title)")
                                AsyncImage(url: url)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func getFirstPhotoThumbnailURL(albumId: Int) -> URL? {
        let photo = viewModel.photos.first { $0.albumId == albumId }
        guard let thumbnailURL = photo?.thumbnailUrl else { return nil }
        guard let url = URL(string: thumbnailURL) else { return nil }
        return url
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsGrid()
    }
}
