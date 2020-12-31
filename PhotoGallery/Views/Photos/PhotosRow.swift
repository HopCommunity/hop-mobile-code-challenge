//
//  PhotosRow.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/31/20.
//

import SwiftUI

struct PhotosRow: View {
    @EnvironmentObject private var viewModel: PhotoGalleryViewModel
    
    private let rowIndex: Int
    private let photosForRow: [Photo]
    
    init(rowIndex: Int, photosForRow: [Photo]) {
        self.rowIndex = rowIndex
        self.photosForRow = photosForRow
    }
    
    var body: some View {
        HStack {
            ForEach(photosForRow) { photo in
                if let thumbnailURL = URL(string: photo.thumbnailUrl) {
                    NavigationLink(destination: PhotoView(photo: photo)) {
                        AsyncImage(url: thumbnailURL)
                    }
                }
            }
        }
        .padding(.bottom, 5)
    }
}

struct PhotosRow_Previews: PreviewProvider {
    static var previews: some View {
        PhotosRow(rowIndex: 0, photosForRow: [])
    }
}
