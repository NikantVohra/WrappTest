//
//  SongModelTests.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/15/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import XCTest
@testable import WrappTest
import Mapper

class SongModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSongModel() {
        let songDict = ["title":"Hold Up", "artist":"Beyonce", "image":"http://ichef.live.bbci.co.uk/images/ic/512x512/p03s2dd7.jpg"]
        do {
            let song = try Song(map: Mapper(JSON: songDict))
            XCTAssertEqual(song.artist, "Beyonce")
            XCTAssertNil(song.label)
            XCTAssertEqual(song.title, "Hold Up")
            XCTAssertEqual(song.imageURL, "http://ichef.live.bbci.co.uk/images/ic/512x512/p03s2dd7.jpg")

 
        }
        catch {
            
        }
        
    }
}
