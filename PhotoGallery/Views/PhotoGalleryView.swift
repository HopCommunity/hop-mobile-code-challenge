//
//  ContentView.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/18/20.
//

import SwiftUI

struct PhotoGalleryView: View {
    @ObservedObject private var viewModel = PhotoGalleryViewModel(apiService: APIService.instance)
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            List(viewModel.photos) { photo in
                VStack {
                    Text(photo.title)
                    if let thumbnailURL = URL(string: photo.thumbnailUrl),
                       let imageURL = URL(string: photo.url) {
                        NavigationLink(destination: AsyncImage(url: imageURL, placeholder: Text("Loading..."))) {
                            AsyncImage(url: thumbnailURL, placeholder: Text("Loading..."))
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            }
            .onAppear { self.viewModel.getPhotos() }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error fetching photos"),
                      message: Text("\(viewModel.networkError?.localizedDescription ?? "")"))
            }
            .onReceive(viewModel.$networkError) { output in
                showingAlert = (output != nil)
            }
            .navigationBarTitle(Text("Photo Gallery"))
        }
    }
}

struct PhotoGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGalleryView()
    }
}
