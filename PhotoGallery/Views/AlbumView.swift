//
//  AlbumView.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/28/20.
//

import SwiftUI

struct AlbumView: View {
    @EnvironmentObject private var viewModel: PhotoGalleryViewModel
    
    var body: some View {
        List(viewModel.albums) { album in
            Text("Album")
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumView()
    }
}
