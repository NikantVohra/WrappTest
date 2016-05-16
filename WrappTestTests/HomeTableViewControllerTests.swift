//
//  SongDetailViewControllerTests.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/15/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import XCTest
@testable import WrappTest
import Mapper

class HomeTableViewControllerTests: XCTestCase {
    
    var vc : HomeTableViewController?

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        vc = navigationController.topViewController as? HomeTableViewController
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = vc
        
        let _ = navigationController.view
        let _ = vc!.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHomeTableViewControllerDataSource() {
        let datasourceRefreshExpectation = expectationWithDescription("datasourceRefreshExpectation")
        var tableViewRows = 0
        vc?.dataSource?.refreshTableView({ (error) in
            if(error == nil) {
                self.vc?.tableView.reloadData()
                tableViewRows = (self.vc?.dataSource?.songs.count)!
                datasourceRefreshExpectation.fulfill()
            }
            else {
                GlobalVariables.songFetchCount = 0
            }
        })
        self.waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertEqual(tableViewRows, GlobalVariables.songFetchCount)
        }

    }
    
    func testHomeTableViewControllerSearch() {
        vc?.dataSource?.filterContentForSearchText("Down")
        for song in (vc?.dataSource?.filteredSongs)! {
            XCTAssertTrue(song.title.lowercaseString.containsString("down"))
        }
    }


}
