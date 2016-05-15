//
//  HomeTableViewController.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var selectedSong : Song?
    let songDetailSegueIdentifier = "songDetailSegue"
    
    let searchController = UISearchController(searchResultsController: nil)

    
    var dataSource: HomeScreenDataSource? {
        didSet{
            if let dataSource = self.dataSource {
                self.tableView.dataSource = dataSource
                tableView.setNeedsLayout()
                dataSource.refreshTableView({ (error) in
                    if error != nil {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.showErrorView()
                        })
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        self.dataSource = HomeScreenDataSource(songsTable: self.tableView, searchController: searchController)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if searchController.active && searchController.searchBar.text != "" {
            self.selectedSong = self.dataSource?.filteredSongs[indexPath.row]
        }
        else {
            self.selectedSong = self.dataSource?.songs[indexPath.row]
        }
        self.performSegueWithIdentifier(songDetailSegueIdentifier, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == songDetailSegueIdentifier) {
            let destinationVC:SongDetailViewController = segue.destinationViewController as! SongDetailViewController
            destinationVC.song = self.selectedSong
        }

    }
    
    private func showErrorView() {
        let alert = UIAlertController(title: "Unable to fetch data.", message: "Please check your connection.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

extension HomeTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        dataSource!.filterContentForSearchText(searchController.searchBar.text!)
    }
}
