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
                AlbumsRow(rowIndex: rowIndex)
            }
        }
        .padding([.leading, .trailing], 5)
    }
}

struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        AlbumsGrid()
    }
}
