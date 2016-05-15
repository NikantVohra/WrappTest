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

    var songFetchCount = 47

    var dataSource : HomeScreenDataSource?
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: NSBundle.mainBundle())
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let vc = navigationController.topViewController as? HomeTableViewController
        
        UIApplication.sharedApplication().keyWindow!.rootViewController = vc
        
        // The One Weird Trick!
        let _ = navigationController.view
        let _ = vc!.view
        dataSource = HomeScreenDataSource(songsTable: (vc?.tableView)!)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func DISABLED_testDataSourceRefreshOperation() {
        let datasourceRefreshExpectation = expectationWithDescription("datasourceRefreshExpectation")
        var tableViewRows = 0
        dataSource?.refreshTableView({ (error) in
            if(error == nil) {
                self.dataSource?.songsTable.reloadData()
                tableViewRows = (self.dataSource?.songsTable.numberOfRowsInSection(0))!
                datasourceRefreshExpectation.fulfill()
            }
            else {
                self.songFetchCount = 0
            }
        })
        self.waitForExpectationsWithTimeout(10) { (error) in
            XCTAssertEqual(tableViewRows, self.songFetchCount)
        }

    }

}
