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
    
    //GET method to recieve all books in library
    static func getAllBooks(completion: @escaping ([[String: Any]]) -> () ) {
        
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
    
    //GET method to recieve specific book in library
    static func getBook(bookURL: String, completion: @escaping ([String:Any]) -> () ) {
        
        let urlString = server + bookURL
        let url = URL(string: urlString)
        
        guard let unwrappedUrl = url else {  return  }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: unwrappedUrl) { (data, response, error) in
            
            guard let uData = data else { return }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with:uData, options: []) as! [String:Any]
                completion(responseJSON)
            } catch {
                
            }
        }
        dataTask.resume()
    }
    
    //POST method to add new books to library
    static func addNew(_ book: [String: Any], completion: @escaping (Bool) -> () ) {
        let urlString = server + "/books"
        let url = URL(string: urlString)
        
        let jsonData = try? JSONSerialization.data(withJSONObject: book)
        
        guard let unwrappedUrl = url else { return }
        
        var urlRequest = URLRequest(url: unwrappedUrl)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true)
                }
            }
            
        }
        dataTask.resume()
    }
    
    //PUT method to update an existing book in library
    static func updateBook(bookURL: String, update book: [String: Any], completion: @escaping (Bool) -> () ) {
        
        let urlString = server + bookURL
        let url = URL(string: urlString)
        
        let jsonData = try? JSONSerialization.data(withJSONObject: book)
        
        guard let unwrappedUrl = url else { return }
        
        var urlRequest = URLRequest(url: unwrappedUrl)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "PUT"
        urlRequest.httpBody = jsonData
        

        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true)
                }
            }
        }
        dataTask.resume()
    }
    
    //DELETE method to remove specific book
    static func deleteBook(bookURL: String, completion: @escaping (Bool) -> () ) {
        let urlString = server + bookURL
        let url = URL(string: urlString)
        guard let unwrappedUrl = url else { return }
        
        var urlRequest = URLRequest(url: unwrappedUrl)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "DELETE"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 204 {
                    completion(true)
                }
            }
        }
        dataTask.resume()
    }
    
    //DELETE method to clear all books in library
    static func deleteAllBooks(completion: @escaping (Bool) -> () ) {
        
        let urlString = server + "/clean"
        let url = URL(string: urlString)
        guard let unwrappedUrl = url else { return }
        var urlRequest = URLRequest(url: unwrappedUrl)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "DELETE"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    completion(true)
                }
            }
        }
        dataTask.resume()
    }
    
}
