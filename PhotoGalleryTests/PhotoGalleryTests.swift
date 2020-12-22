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

    func testAPIServiceRequest_noPhotos() throws {
        let photos: [Photo] = []
        let data = try JSONEncoder().encode(photos)
        let vm = PhotoGalleryViewModel(apiService: MockAPIService(data: data))
        vm.getPhotos()
        XCTAssert(vm.photos.count == photos.count)
    }
    
    func testAPIServiceRequest_onePhoto() throws {
        let photos = [Photo(albumId: 1, id: 1, title: "Photo", url: "URL", thumbnailUrl: "thumbnailURL")]
        let data = try JSONEncoder().encode(photos)
        let vm = PhotoGalleryViewModel(apiService: MockAPIService(data: data))
        vm.getPhotos()
        XCTAssert(vm.photos.count == photos.count)
    }
    
    func testAPIServiceRequest_fivePhotos() throws {
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
