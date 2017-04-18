//
//  BooksManager.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class BookManager {
    
    static var main = BookManager()
    private init() {}
    
    var list = [Book]()
    
    func loadBooks(handler: @escaping () -> () ) {
        ProlificAPI.getAllBooks { (json) in
            self.list.removeAll()
            for data in json {
                let book = Book(data: data)
                self.list.append(book)
            }
            handler()
        }
    }
    
}

