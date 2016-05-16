//
//  Song.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import Foundation
import Mapper


struct PropertyKey {
    static let titleKey = "title"
    static let artistKey = "artist"
    static let imageURLKey = "image"
    static let labelKey = "label"
}

final class Song : NSObject, Mappable, Comparable {
    let title : String
    let artist : String
    let label : String?
    let imageURL : String
    
    //Mapper initializer that allows direct conversion of Json Dictionary to Song struct
    required init(map: Mapper) throws {
        try title = map.from(PropertyKey.titleKey)
        try artist = map.from(PropertyKey.artistKey)
        try imageURL = map.from(PropertyKey.imageURLKey)
        label = map.optionalFrom(PropertyKey.labelKey)
        
    }

    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(title, forKey: PropertyKey.titleKey)
        aCoder.encodeObject(artist, forKey: PropertyKey.artistKey)
        aCoder.encodeObject(imageURL, forKey: PropertyKey.imageURLKey)
        aCoder.encodeObject(label, forKey: PropertyKey.labelKey)
    }
    
    init(coder aDecoder: NSCoder!) {
        title = aDecoder.decodeObjectForKey(PropertyKey.titleKey) as! String
        artist = aDecoder.decodeObjectForKey(PropertyKey.artistKey) as! String
        label = aDecoder.decodeObjectForKey(PropertyKey.labelKey) as? String
        imageURL = aDecoder.decodeObjectForKey(PropertyKey.imageURLKey) as! String
    }


}

//Comparable protocol methods for Song Struct
func < (lhs: Song, rhs: Song) -> Bool {
    return lhs.title < rhs.title
}

func == (lhs: Song, rhs: Song) -> Bool {
    return lhs.title == rhs.title
}






