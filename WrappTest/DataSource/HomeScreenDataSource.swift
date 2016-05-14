//
//  HomeScreenDataSource.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
class HomeScreenDataSource: NSObject, UITableViewDataSource {

    // MARK: - Table view data source
    
    let songsTable: UITableView
    var songs : [Song] = []
    init(songsTable:UITableView){
        self.songsTable = songsTable
        super.init()
    }
    
    func refreshTableView() {
        SongFetchOperation().fetchSongs { (songs, error) in
            if error == nil {
                self.songs = songs
                dispatch_async(dispatch_get_main_queue(), {
                    self.songsTable.reloadData()
                })
            }
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 100.0
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SongCell", forIndexPath: indexPath) as! SongTableViewCell
        let song = songs[indexPath.row]
        cell.configureCell(song)
        cell.imageView?.kf_setImageWithURL(NSURL(string: song.imageURL)!, placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
}
