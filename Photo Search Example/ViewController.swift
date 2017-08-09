//
//  ViewController.swift
//  Photo Search Example
//
//  Created by Aanya Jhaveri on 8/8/17.
//  Copyright © 2017 Aanya Jhaveri. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

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
                        if let responseObject = responseObject {
                            print("Response: " + (responseObject as AnyObject).description)
                            
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

