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

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = AFHTTPSessionManager()
        let searchParameters:[String:Any] = ["method": "flickr.photos.search",
                                             "api_key": "e8b64840adaafc462120e621e5f01a67",
                                             "format": "json",
                                             "nojsoncallback": 1,
                                             "text": "dogs",
                                             "extras": "url_m",
                                             "per_page": 5]
        
        manager.get("https://api.flickr.com/services/rest/",
                    parameters: searchParameters,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject: Any?) in
                        if let photos = responseObject["photos"] as? [String: AnyObject?] {
                            if let photoArray = photos["photo"] as? [[String: AnyObject]] {
                                self.scrollView.contentSize = CGSize(width: 320, height: 320 * CGFloat(photoArray.count))
                                for (i,photoDictionary) in photoArray.enumerate() {
                                    if let imageURLString = photoDictionary["url_m"] as? String {
                                        let imageData = NSData(contentsOf: URL(string: imageURLString)!)
                                        if let imageDataUnwrapped = imageData {
                                            let imageView = UIImageView(image: UIImage(data: imageDataUnwrapped as Data))
                                           imageview.frame = CGRect(x: 0, y: 320 * CGFLoat(i), width: 320, height: 320)
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


}

