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

    let songFetchCount = 47

    var dataSource : HomeScreenDataSource?
    override func setUp() {
        super.setUp()
        let homeViewController = HomeTableViewController()
        dataSource = HomeScreenDataSource(songsTable: homeViewController.tableView)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDataSourceRefreshOperation() {
        let datasourceRefreshExpectation = expectationWithDescription("datasourceRefreshExpectation")
        var tableViewRows = 0
        dataSource?.refreshTableView({ (error) in
            tableViewRows = (self.dataSource?.songsTable.numberOfRowsInSection(0))!
            datasourceRefreshExpectation.fulfill()
        })
        self.waitForExpectationsWithTimeout(5) { (error) in
            XCTAssertEqual(tableViewRows, self.songFetchCount)
        }

    }

}
