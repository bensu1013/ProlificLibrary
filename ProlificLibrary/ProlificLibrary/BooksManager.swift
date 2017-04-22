//
//  BooksManager.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

final class BookManager {
    
    var selectedBook: Book?
    var list = [Book]()
    private var baseList = [Book]()
    static var main = BookManager()
    
    private init() {}
    
    //calls on api to recent list of books and populate array
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
    
    //filters list of titles by argument
    func searchTitles(for text: String) {
        var searchList = [Book]()
        for book in baseList {
            if book.title.lowercased().contains(text.lowercased()) {
                searchList.append(book)
            }
        }
        list = searchList
    }
    
    //filters list of authors by argument
    func searchAuthors(for text: String) {
        var searchList = [Book]()
        for book in baseList {
            if book.author.lowercased().contains(text.lowercased()) {
                searchList.append(book)
            }
        }
        list = searchList
    }
    
    //clears and potential filters
    func clearSearch() {
        list = baseList
    }
    
    //sets selectedBook property to index of list
    func select(at index: Int) {
        if (0...list.count-1).contains(index) {
            selectedBook = list[index]
        }
    }
    
    //checks server for updates of selectedBook
    func refreshSelectedBook(handler: @escaping () -> () ) {
        if let unwrappedBook = selectedBook {
            ProlificAPI.getBook(bookURL: unwrappedBook.url, completion: { (book) in
                self.selectedBook = book
                handler()
            })
        }
    }
    
    //puts name and timestamp under selectedBook in server
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
    
    //puts new data under selectedBook
    func updateSelectedBook(with data: [String: Any], handler: @escaping () -> () ) {
        guard let unwrappedBook = selectedBook else {
            return
        }
        ProlificAPI.updateBook(bookURL: unwrappedBook.url, update: data, completion: { (completed) in
            handler()
        })
    }
    
    //remove selectedBook from server
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
    
    //The end of all books as we know it!
    func bookpocalypse(handler: @escaping () -> () ) {
        ProlificAPI.deleteAllBooks(completion: { (completed) in
                self.list.removeAll()
                handler()
        })
    }
    
    //creates new book from user input and Posts it to the server
    func addNewBook(with data: [String: Any], handler: @escaping () -> () ) {
        ProlificAPI.addNew(data, completion: { (completed) in
            handler()
        })
    }
    
}

