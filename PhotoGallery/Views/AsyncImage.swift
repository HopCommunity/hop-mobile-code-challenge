//
//  AsyncImage.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/20/20.
//

import SwiftUI

struct AsyncImage: View {
    @StateObject private var imageLoader: ImageLoader
    private let placeholder: Text
    
    init(url: URL, placeholder: Text) {
        self.placeholder = placeholder
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: imageLoader.load)
    }
    
    private var content: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: URL(string: "https://via.placeholder.com/600/92c952")!,
                   placeholder: Text("Loading..."))
    }
}
