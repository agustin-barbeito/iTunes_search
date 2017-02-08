//
//  SearchViewController.swift
//  iTunes_search
//
//  Created by Agustin Barbeito on 1/25/17.
//  Copyright © 2017 Agustin Barbeito. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate

{
    
    var connection = iTunesAPI()
    
    var numberOfItems = 0

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var goButton: UIButton!
    
    @IBOutlet weak var scrollMusicView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var searchField: UITextField!
    
    
    override func viewDidLoad()
        
    {
        super.viewDidLoad()
        
        goButton.backgroundColor = color1
        goButton.setTitleColor(color2, forState: UIControlState.Normal)
        goButton.layer.borderColor = UIColor.blackColor().CGColor
        goButton.layer.borderWidth = 0.8
        goButton.layer.cornerRadius = 5
        
        pageControl.numberOfPages = 0
        
        scrollMusicView.delegate = self
        scrollMusicView.backgroundColor = UIColor.whiteColor()
        
        self.searchField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func goButtonTapped(sender: AnyObject) {
        
        searchField.resignFirstResponder()
        
        if searchField.text != "" {
            
            self.connection.searchGetAlbum(searchField.text!, completion:  { (album: Album) in
                
                self.numberOfItems += 1
                
                self.scrollMusicView.contentSize = CGSizeMake(CGFloat(self.numberOfItems) * self.scrollMusicView.frame.size.width, self.scrollMusicView.frame.size.height)
                
                self.scrollMusicView.backgroundColor = color3
                
                let musicView = NSBundle.mainBundle().loadNibNamed("MusicView", owner: self, options: nil)[0] as! MusicView
                
                musicView.frame = CGRectMake(CGFloat(self.numberOfItems - 1) * self.scrollMusicView.frame.size.width, 0, self.scrollMusicView.frame.size.width, self.scrollMusicView.frame.size.height)
                
                musicView.addData(album)
                
                self.scrollMusicView.scrollRectToVisible(musicView.frame, animated: true)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.pageControl.numberOfPages = self.numberOfItems
                    
                    self.pageControl.currentPage = self.numberOfItems.successor()
                    musicView.updateConstraints()
                    
                    self.scrollMusicView.addSubview(musicView)
                })
            })
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let page = Int(scrollMusicView.contentOffset.x / scrollMusicView.frame.size.width)
        
        pageControl.currentPage = page
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        goButtonTapped(textField)
        
        return true
    
    }
    
    func dismissKeyboard(){
        
        self.view.endEditing(true)
    }
}