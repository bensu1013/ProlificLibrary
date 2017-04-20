//
//  BooksManager.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class BookManager {
    
    var selectedBook: Book?
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
    
    func select(at index: Int) {
        if (0...list.count-1).contains(index) {
            selectedBook = list[index]
        }
    }
    
    func refreshSelectedBook(handler: @escaping () -> () ) {
        if let unwrappedBook = selectedBook {
            ProlificAPI.getBook(bookURL: unwrappedBook.url, completion: { (book) in
                self.selectedBook = book
                handler()
            })
        }
    }
    
    func checkOutSelectedBook(with data: [String: Any], handler: @escaping () -> () ) {
        guard let unwrappedBook = selectedBook else {
            return
        }
        ProlificAPI.updateBook(bookURL: unwrappedBook.url, update: data, completion: { (completed) in
            self.refreshSelectedBook {
                handler()
            }
        })
    }
    
    func updateSelectedBook(with data: [String: Any], handler: @escaping () -> () ) {
        guard let unwrappedBook = selectedBook else {
            return
        }
        ProlificAPI.updateBook(bookURL: unwrappedBook.url, update: data, completion: { (completed) in
            handler()
        })
    }
    
    
    func deleteSelectedBook(handler: @escaping () -> () ) {
        guard let unwrappedBook = selectedBook else {
            return
        }
        ProlificAPI.deleteBook(bookURL: unwrappedBook.url, completion: { (complete) in
            self.loadBooks {
                handler()
            }
        })
    }
    
    func bookpocalypse(handler: @escaping () -> () ) {
        ProlificAPI.deleteAllBooks(completion: { (completed) in
                self.list.removeAll()
                handler()
        })
    }
    
    func addNewBook(with data: [String: Any], handler: @escaping () -> () ) {
        ProlificAPI.addNew(data, completion: { (completed) in
            handler()
        })
    }
    
}

