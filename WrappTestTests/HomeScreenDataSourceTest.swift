//
//  HomeScreenDataSourceTest.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/15/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import XCTest
@testable import WrappTest


class HomeScreenDataSourceTest: XCTestCase {


    var dataSource : HomeScreenDataSource?
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = navigationController.topViewController as? HomeTableViewController
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = vc
        
        let _ = navigationController.view
        let _ = vc!.view
        dataSource = vc?.dataSource
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testDataSourceRefreshOperation() {
        let datasourceRefreshExpectation = expectationWithDescription("datasourceRefreshExpectation")
        var tableViewRows = 0
        dataSource?.refreshTableView({ (error) in
            if(error == nil) {
                tableViewRows = (self.dataSource?.songs.count)!
                datasourceRefreshExpectation.fulfill()
            }
            else {
                GlobalVariables.songFetchCount = 0
            }
        })
        self.waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertEqual(tableViewRows, GlobalVariables.songFetchCount)
        }

    }

}
