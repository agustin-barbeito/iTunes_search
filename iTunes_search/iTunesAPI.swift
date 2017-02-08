//
//  iTunesAPI.swift
//  iTunes_search
//
//  Created by Agustin Barbeito on 1/26/17.
//  Copyright © 2017 Agustin Barbeito. All rights reserved.
//

import UIKit

class iTunesAPI: NSObject {
    
    func searchGetAlbum(string: String, completion: (Album) -> ())
    
    {
        
        let escapedString = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        
        let url = NSURL(string: "https://itunes.apple.com/search?term=\(escapedString!)&media=music")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!)
        { (data, response, error) in
            
            if error == nil {
                
                let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                
                let results = json["results"] as! [Dictionary<String,AnyObject>]
                
                if let result = results.first                    
                    
                    {
                        
                        let artist = result["artistName"] as! String
                        
                        let artworkImgURL = result["artworkUrl100"] as! String
                        
                        let title = result["collectionName"] as! String
                        
                        let genre = result["primaryGenreName"] as! String
                        
                        let album = Album(title: title, artist: artist, genre: genre, artworkImgURL: artworkImgURL)
                        
                        completion(album)
                }
            }
        }
        
    task.resume()
        
    }
}