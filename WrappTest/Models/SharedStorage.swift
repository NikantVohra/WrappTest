//
//  SharedStorage.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/16/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import Foundation

class SharedStorage {
    static let sharedInstance = SharedStorage()
    let SongsKey = "songs"
    
    
    func saveSongs(songs : [Song]) {
        NSUserDefaults.standardUserDefaults().setObject(NSKeyedArchiver.archivedDataWithRootObject(songs), forKey: SongsKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func getSavedSongs() -> [Song]? {
        let dataRepresentingSavedSongs = NSUserDefaults.standardUserDefaults().objectForKey(SongsKey) as? NSData
        if let songsData = dataRepresentingSavedSongs {
            let songs = NSKeyedUnarchiver.unarchiveObjectWithData(songsData)
            return songs as? [Song]
        }
        return nil

    }
    

}