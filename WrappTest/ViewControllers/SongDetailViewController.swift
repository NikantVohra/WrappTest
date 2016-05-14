//
//  SongDetailViewController.swift
//  WrappTest
//
//  Created by Vohra, Nikant on 5/14/16.
//  Copyright © 2016 Vohra, Nikant. All rights reserved.
//

import UIKit
import Kingfisher

class SongDetailViewController: UIViewController {

    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    var song : Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentSong = self.song else {return}
        self.songImageView.kf_setImageWithURL(NSURL(string:currentSong.imageURL)!, placeholderImage: UIImage(named: "placeholder"))
        self.artistNameLabel.text = currentSong.artist
        self.songNameLabel.text = currentSong.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
}
