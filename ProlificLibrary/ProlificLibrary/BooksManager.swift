//
//  BooksManager.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class BookManager {
    
    var list = [Book]()
    private var baseList = [Book]()
    static var main = BookManager()
    
    private init() {
    }
    
    func loadBooks(handler: @escaping () -> () ) {
        ProlificAPI.getAllBooks { (json) in
            self.baseList.removeAll()
            for data in json {
                let book = Book(data: data)
                self.baseList.append(book)
            }
            self.list = self.baseList
            handler()
        }
    }
    
    func searchTitles(for text: String) {
        var searchList = [Book]()
        for book in baseList {
            if book.title.lowercased().contains(text.lowercased()) {
                searchList.append(book)
            }
        }
        list = searchList
    }
    
    func searchAuthors(for text: String) {
        var searchList = [Book]()
        for book in baseList {
            if book.author.lowercased().contains(text.lowercased()) {
                searchList.append(book)
            }
        }
        list = searchList
    }
    
    func clearSearch() {
        list = baseList
    }
    
}

