//
//  AlbumCell.swift
//  PhotoGallery
//
//  Created by Paul Carroll on 12/30/20.
//

import SwiftUI

struct AlbumCell: View {
    private let title: String
    private let url: URL
    
    init(title: String, url: URL) {
        self.title = title
        self.url = url
    }
    
    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .foregroundColor(.black)
                .frame(height: 42.5)
            AsyncImage(url: url)
                .cornerRadius(5)
        }
        .padding(.bottom, 5)
    }
}

struct AlbumCell_Previews: PreviewProvider {
    static var previews: some View {
        AlbumCell(title: "preview album", url: URL(string: "")!)
    }
}
