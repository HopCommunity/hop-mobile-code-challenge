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
        let vm = PhotoGalleryViewModel(apiService: MockAPIService.instance)
        vm.getPhotos()
        XCTAssert(vm.photos.count == 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
