//
//  Song.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import Foundation
import Mapper


struct Song : Mappable, Comparable {
    let title : String
    let artist : String
    let label : String?
    let imageURL : String
    
    //Mapper initializer that allows direct conversion of Json Dictionary to Song struct
    init(map: Mapper) throws {
        try title = map.from("title")
        try artist = map.from("artist")
        try imageURL = map.from("image")
        label = map.optionalFrom("label")
    }
    
}

//Comparable protocol methods for Song Struct
func < (lhs: Song, rhs: Song) -> Bool {
    return lhs.title < rhs.title
}

func == (lhs: Song, rhs: Song) -> Bool {
    return lhs.title == rhs.title
}