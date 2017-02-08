//
//  Album.swift
//  iTunes_search
//
//  Created by Agustin Barbeito on 1/25/17.
//  Copyright © 2017 Agustin Barbeito. All rights reserved.
//

import Foundation
import UIKit

class Album: NSObject {
    
    var title: String!
    var artist: String!
    var genre: String!
    var artworkImgURL: String!
    
    init(title: String, artist: String, genre: String, artworkImgURL: String)
    
    {
    
    super.init()
        
    self.title = title
    self.artist = artist
    self.genre = genre
    self.artworkImgURL = artworkImgURL
    
    }
}