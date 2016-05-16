//
//  SongOperationFetchTest.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/15/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import XCTest
@testable import WrappTest

class ASongOperationFetchTest: XCTestCase {

    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSongFetchOperation() {
        let songFetchExpectation = expectationWithDescription("songFetchExpectation")
        var testSongs : [Song] = []
        SongFetchOperation().fetchSongs { (songs, error) in
            if error == nil {
                testSongs = songs
                GlobalVariables.songFetchCount = songs.count
                songFetchExpectation.fulfill()
            }
            else {
                GlobalVariables.songFetchCount = 0
            }
        }
        self.waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertEqual(testSongs.count, GlobalVariables.songFetchCount)
        }
    }

}
