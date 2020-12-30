//
//  AlbumsRow.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/30/20.
//

import SwiftUI

struct AlbumsRow: View {
    @EnvironmentObject private var viewModel: PhotoGalleryViewModel
    
    private let rowIndex: Int
    
    init(rowIndex: Int) {
        self.rowIndex = rowIndex
    }
    
    var body: some View {
        HStack {
            if let url = getFirstPhotoThumbnailURL(albumId: leftAlbum(rowIndex: rowIndex).id) {
                NavigationLink(destination: AlbumView(album: leftAlbum(rowIndex: rowIndex))) {
                    AlbumCell(title: leftAlbum(rowIndex: rowIndex).title, url: url)
                }
            }
            if let url = getFirstPhotoThumbnailURL(albumId: rightAlbum(rowIndex: rowIndex).id) {
                NavigationLink(destination: AlbumView(album: rightAlbum(rowIndex: rowIndex))) {
                    AlbumCell(title: rightAlbum(rowIndex: rowIndex).title, url: url)
                }
            }
        }
        .padding(.bottom, 5)
    }
    
    private func getFirstPhotoThumbnailURL(albumId: Int) -> URL? {
        let photo = viewModel.photos.first { $0.albumId == albumId }
        guard let thumbnailURL = photo?.thumbnailUrl else { return nil }
        guard let url = URL(string: thumbnailURL) else { return nil }
        return url
    }
    
    private func leftAlbum(rowIndex: Int) -> Album {
        return viewModel.albums[rowIndex*2]
    }
    
    private func rightAlbum(rowIndex: Int) -> Album {
        return viewModel.albums[rowIndex*2+1]
    }
}

struct AlbumsRow_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsRow(rowIndex: 0)
    }
}
