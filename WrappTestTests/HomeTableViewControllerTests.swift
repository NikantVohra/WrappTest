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
    var songFetchCount = 47

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        vc = navigationController.topViewController as? HomeTableViewController
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = vc
        
        // The One Weird Trick!
        let _ = navigationController.view
        let _ = vc!.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHomeTableViewController() {
        let datasourceRefreshExpectation = expectationWithDescription("datasourceRefreshExpectation")
        var tableViewRows = 0
        vc?.dataSource?.refreshTableView({ (error) in
            if(error == nil) {
                self.vc?.tableView.reloadData()
                tableViewRows = (self.vc?.dataSource?.songs.count)!
                datasourceRefreshExpectation.fulfill()
            }
            else {
                self.songFetchCount = 0
            }
        })
        self.waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertEqual(tableViewRows, self.songFetchCount)
        }

    }


}
