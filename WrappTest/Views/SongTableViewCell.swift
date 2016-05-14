//
//  SongTableViewCell.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import UIKit


class SongTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    
    
    func configureCell(song : Song) {
        songTitleLabel.text = song.title
        artistNameLabel.text = song.artist
        songImageView?.kf_setImageWithURL(NSURL(string:song.imageURL)!, placeholderImage: UIImage(named: "placeholder"))
    }
    
}
