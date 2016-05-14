//
//  HomeTableViewController.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = HomeScreenDataSource(songsTable: self.tableView)
    }
    var dataSource: HomeScreenDataSource?{
        didSet{
            if let dataSource = self.dataSource{
                self.tableView.dataSource = dataSource
                tableView.setNeedsLayout()
                dataSource.refreshTableView()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    


}
