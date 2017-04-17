//
//  BooksManager.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class BooksManager {
    
    static var main = BooksManager()
    private init() {}
    
    var list = [Book]()
    
    func loadBooks() {
        
        ProlificAPI.getAllBooks { (json) in
            
            for data in json {
                
                dump(data)
                let book = Book(data: data)
                
            }
            
        }
        
    }
    
}

class Book {

    
    var author:     String?
    var title:      String?
    var url:        String?
    var id:         Int?
    var categories: String?
    var publisher:  String?
    var checkedOut: String?
    var checkedBy:  String?
    
    init(data: [String:Any]) {
        if let auth = data["author"] as? String {
            print(auth)
        } else {
            print("nope")
        }
    }
    
}


//
//"lastCheckedOut": null,
//"lastCheckedOutBy": null,
