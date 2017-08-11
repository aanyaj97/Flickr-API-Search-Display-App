//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Aanya Jhaveri on 8/8/17.
//  Copyright © 2017 Aanya Jhaveri. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchFlickrBy("dogs")
        
    }
    
    func searchFlickrBy(_ searchString:String) {
        let manager = AFHTTPSessionManager()
        let searchParameters:[String:Any] = ["method": "flickr.photos.search",
                                             "api_key": "f1f0dc8e5fa992cc772ebfc67dd23130",
                                             "format": "json",
                                             "nojsoncallback": 1,
                                             "text": searchString,
                                             "extras": "url_m",
                                             "per_page": 5]
        manager.get("https://api.flickr.com/services/rest/",
                    parameters: searchParameters,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject: Any?) in
                        if let photos = (responseObject as? [String: AnyObject?])?["photos"] {
                            if let photoArray = photos?["photo"] as? [[String: AnyObject]] {
                                let imageWidth = self.view.frame.width
                                self.scrollView.contentSize = CGSize(width: 320, height: 320 * CGFloat(photoArray.count))
                                for (i,photoDictionary) in photoArray.enumerated() {
                                    if let imageURLString = photoDictionary["url_m"] as? String {
                                        let imageView = UIImageView(frame: CGRect(x: 0, y: imageWidth*CGFloat(i), width: imagewidth, height: imagewidth))
                                        if let url = URL(string: imageURLString) {
                                            imageView.setImageWith(url)
                                            self.scrollView.addSubview(imageView)
                                        }
                                    }
                                }
                            }
                        }
        }) {(operation:URLSessionDataTask?, error: Error) in
    print("Error: " + error.localizedDescription)
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            searchFlickrBy(searchText)
        }
    }

}
