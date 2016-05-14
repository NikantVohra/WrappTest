//
//  SongFetchOperation.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import Foundation

class SongFetchOperation {
    
    let fetchURL = "http://www.bbc.co.uk/radio1/playlist.json"
    
    internal func fetchSongs(completionHandler completion : (songs : [Song], error : NSError?) -> Void) {
        loadDataFromURL(NSURL(string: fetchURL)!) { (data, error) in
            var json: [String: AnyObject]!
            var songs : [Song] = []
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as? [String: AnyObject]
                guard let playList = json["playlist"] as? NSDictionary else {return}
                for playListType in playList.allKeys {
                    guard let songArray = playList[(playListType as? NSString)!] as? NSArray else {return}
                    if let currentSongs = Song.from(songArray) {
                        songs.appendContentsOf(currentSongs)
                    }
                }
                completion(songs: songs, error: nil)
                
            } catch {
                print(error)
            }

        }
    }
    
    private func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let loadDataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let responseError = error {
                completion(data: nil, error: responseError)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let statusError = NSError(domain:"com.nikant", code:httpResponse.statusCode, userInfo:[NSLocalizedDescriptionKey : "HTTP status code has unexpected value."])
                    completion(data: nil, error: statusError)
                } else {
                    completion(data: data, error: nil)
                }
            }
        }
        
        loadDataTask.resume()
    }

}