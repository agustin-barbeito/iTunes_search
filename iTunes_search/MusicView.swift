//
//  MusicView.swift
//  iTunes_search
//
//  Created by Agustin Barbeito on 1/23/17.
//  Copyright © 2017 Agustin Barbeito. All rights reserved.
//

import UIKit

class MusicView: UIView {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var artistDetailLabel: UILabel!
    @IBOutlet weak var genreDetailLabel: UILabel!
    
    func addData(album: Album)
    
    {
        
        albumImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: album.artworkImgURL)!)!)
        
        titleLabel.text = album.title
        artistDetailLabel.text = album.artist
        genreDetailLabel.text = album.genre
        
    }
}
