//
//  Song.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import Foundation
import Mapper


struct Song : Mappable{
    let title : String
    let artist : String
    let label : String?
    let imageURL : String
    
    init(map: Mapper) throws {
        try title = map.from("title")
        try artist = map.from("artist")
        try imageURL = map.from("imageURL")
        label = map.optionalFrom("label")
        
    }
    
}