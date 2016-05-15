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
        let vc = HomeTableViewController()
        dataSource = HomeScreenDataSource(songsTable: vc.tableView, searchController: vc.searchController)
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
