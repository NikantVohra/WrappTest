//
//  SongOperationFetchTest.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/15/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import XCTest
@testable import WrappTest

class SongOperationFetchTest: XCTestCase {

    let songFetchCount = 15
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSongFetchOperation() {
        let songFetchExpectation = expectationWithDescription("songFetchExpectation")
        var testSongs : [Song] = []
        SongFetchOperation().fetchSongs { (songs, error) in
            testSongs = songs
            songFetchExpectation.fulfill()
        }
        self.waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertEqual(testSongs.count, self.songFetchCount)
        }
    }

}
