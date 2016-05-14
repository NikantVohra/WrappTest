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
    
    private func showErrorView() {
        let alert = UIAlertController(title: "Unable to fetch data.", message: "Please check your connection.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

}
