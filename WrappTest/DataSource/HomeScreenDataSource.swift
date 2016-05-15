//
//  HomeScreenDataSource.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import UIKit
import Foundation

class HomeScreenDataSource: NSObject, UITableViewDataSource {

    // MARK: - Table view data source
    
    let songsTable: UITableView
    var songs : [Song] = []
    var filteredSongs : [Song] = []
    let searchController : UISearchController
    
    init(songsTable : UITableView, searchController : UISearchController){
        self.songsTable = songsTable
        self.searchController = searchController
        super.init()
    }
    
    func refreshTableView(completion : (error : NSError?) -> Void) {
        SongFetchOperation().fetchSongs { (songs, error) in
            if error == nil {
                self.songs = songs.sort()
                dispatch_async(dispatch_get_main_queue(), {
                    self.songsTable.reloadData()
                })
            }
            completion(error: error)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredSongs.count
        }
        return songs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SongCell", forIndexPath: indexPath) as! SongTableViewCell
        let song : Song
        if searchController.active && searchController.searchBar.text != "" {
            song = filteredSongs[indexPath.row]
        }
        else {
            song = songs[indexPath.row]

        }
        cell.configureCell(song)
        return cell
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredSongs = songs.filter { song in
            return song.title.lowercaseString.containsString(searchText.lowercaseString)
        }
        self.songsTable.reloadData()
    }
}
