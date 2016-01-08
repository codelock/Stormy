//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Apurv Gupta on 09/12/15.
//  Copyright (c) 2015 Apurv Gupta. All rights reserved.
//

import Foundation

class NetworkOperation{
   lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
   lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> ()
    
    init(url:NSURL){
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            //1. Check HTTP response for successful GET request
            if let httpResponse = response as? NSHTTPURLResponse {
                
                switch(httpResponse.statusCode){
                case 200:
                    //2. Create JSON object with data
                    let jsonDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String: AnyObject]
                    completion(jsonDictionary)
                    
                    
                default:
                    println("GET request failed. HTTP  stats code \(httpResponse.statusCode)")

                    
                }
            
            } else {
                println("not a valid HTTP")
            }
            
            
        }
        
        dataTask.resume()
    
    }
    

}