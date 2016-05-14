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
    
    var dataSource: HomeScreenDataSource?{
        didSet{
            if let dataSource = self.dataSource{
                self.tableView.dataSource = dataSource
                tableView.setNeedsLayout()
                dataSource.refreshTableView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = HomeScreenDataSource(songsTable: self.tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedSong = self.dataSource?.songs[indexPath.row]
        self.performSegueWithIdentifier(songDetailSegueIdentifier, sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == songDetailSegueIdentifier) {
            let destinationVC:SongDetailViewController = segue.destinationViewController as! SongDetailViewController
            destinationVC.song = self.selectedSong
        }

    }

}
