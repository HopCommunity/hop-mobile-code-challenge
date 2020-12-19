//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/18/20.
//

import SwiftUI

struct PhotoGalleryView: View {
    @ObservedObject private var viewModel = PhotoGalleryViewModel()
    
    var body: some View {
        List(viewModel.photos) { photo in
            Text(photo.title)
        }
        .onAppear {
            self.viewModel.getPhotos()
        }
    }
}

struct PhotoGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGalleryView()
    }
}
