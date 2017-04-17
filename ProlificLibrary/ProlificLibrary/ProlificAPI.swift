//
//  APIMethods.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct ProlificAPI {
    
    private static var server = "http://prolific-interview.herokuapp.com/58ee814c433358000aae035d"
    
    static func getAllBooks(completion: @escaping ([[String:Any]]) -> () ) {
        
        let urlString = server + "/books"
        let url = URL(string: urlString)
        
        guard let unwrappedUrl = url else {  return  }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: unwrappedUrl) { (data, response, error) in
            
            guard let uData = data else { return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with:uData, options: []) as! [[String:Any]]
                completion(responseJSON)
            } catch {
                
            }
        }
        dataTask.resume()
    }
    
    static func updateBook(bookUrl: String) {
        let urlString = server + bookUrl
        let url = URL(string: urlString)
        
        guard let unwrappedUrl = url else { return }
        
        var urlRequest = URLRequest(url: unwrappedUrl)
        urlRequest.httpMethod = "PUT"
//        urlRequest
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            
            
        }
        dataTask.resume()
    }
    
}
