//
//  PhotosForAlbumView.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/28/20.
//

import SwiftUI

struct PhotosForAlbumView: View {
    @EnvironmentObject private var viewModel: PhotoGalleryViewModel
    
    private let album: Album
    private var photosForAlbum: [Photo]?
    
    init(album: Album) {
        self.album = album
    }
    
    var body: some View {
        ScrollView {
            grid()
        }
        .navigationTitle("Album: \(album.title)")
    }
    
    private func grid() -> some View {
        let photos = getPhotosForAlbum()
        let numberOfRows = (photos.count / 2) + (photos.count % 2)
        
        return VStack(alignment: .leading) {
            ForEach(0..<numberOfRows, id: \.self) { rowIndex in
                PhotosRow(rowIndex: rowIndex, photosForRow: photosForRow(rowIndex: rowIndex))
            }
        }
        .padding([.leading, .trailing], 5)
    }
    
    private func getPhotosForAlbum() -> [Photo] {
        if let photosForAlbum = self.photosForAlbum {
            return photosForAlbum
        }
        return viewModel.photos.filter { photo -> Bool in
            return photo.albumId == album.id
        }
    }
    
    private func photosForRow(rowIndex: Int) -> [Photo] {
        let leftPhoto = getPhotosForAlbum()[rowIndex*2]
        let rightIndex = rowIndex * 2 + 1
        if rightIndex < getPhotosForAlbum().count {
            let rightPhoto = getPhotosForAlbum()[rightIndex]
            return [leftPhoto, rightPhoto]
        } else {
            return [leftPhoto]
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosForAlbumView(album: Album(userId: 1, id: 1, title: "Preview Album"))
    }
}
