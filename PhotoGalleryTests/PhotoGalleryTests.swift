//
//  PhotoGalleryTests.swift
//  PhotoGalleryTests
//
//  Created by Paul Carroll on 12/18/20.
//

import XCTest
@testable import PhotoGallery

class PhotoGalleryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetPhotos_noPhotos() throws {
        let photos: [Photo] = []
        let data = try JSONEncoder().encode(photos)
        let vm = PhotoGalleryViewModel(apiService: MockAPIService(data: data))
        vm.getPhotos()
        XCTAssert(vm.photos.count == photos.count)
    }
    
    func testGetPhotos_onePhoto() throws {
        let photos = [Photo(albumId: 1, id: 1, title: "Photo", url: "URL", thumbnailUrl: "thumbnailURL")]
        let data = try JSONEncoder().encode(photos)
        let vm = PhotoGalleryViewModel(apiService: MockAPIService(data: data))
        vm.getPhotos()
        XCTAssert(vm.photos.count == photos.count)
    }
    
    func testGetPhotos_fivePhotos() throws {
        let photos = [
            Photo(albumId: 1, id: 1, title: "Photo", url: "URL", thumbnailUrl: "thumbnailURL"),
            Photo(albumId: 1, id: 1, title: "Photo", url: "URL", thumbnailUrl: "thumbnailURL"),
            Photo(albumId: 1, id: 1, title: "Photo", url: "URL", thumbnailUrl: "thumbnailURL"),
            Photo(albumId: 1, id: 1, title: "Photo", url: "URL", thumbnailUrl: "thumbnailURL"),
            Photo(albumId: 1, id: 1, title: "Photo", url: "URL", thumbnailUrl: "thumbnailURL")
        ]
        let data = try JSONEncoder().encode(photos)
        let vm = PhotoGalleryViewModel(apiService: MockAPIService(data: data))
        vm.getPhotos()
        XCTAssert(vm.photos.count == photos.count)
    }
    
    func testImageLoader_getPhoto() throws {
        let url = URL(string: "https://via.placeholder.com/600/92c952")!
        guard let image = UIImage(systemName: "a") else {
            XCTFail("Failed to create image")
            return
        }
        guard let data = image.pngData() else {
            XCTFail("Failed to convert image to Data")
            return
        }
        let imageLoader = ImageLoader(apiService: MockAPIService(data: data), url: url)
        XCTAssertNil(imageLoader.image, "imageLoader.image should be nil")
        imageLoader.getPhoto()
        XCTAssertNotNil(imageLoader.image, "imageLoader.image should not be nil")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
