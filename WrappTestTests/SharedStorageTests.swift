//
//  SharedStorageTests.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/16/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import XCTest
@testable import WrappTest

class SharedStorageTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSongStorage() {
        XCTAssertEqual(SharedStorage.sharedInstance.getSavedSongs()?.count, GlobalVariables.songFetchCount)
    }
}
