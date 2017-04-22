//
//  Book.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

struct Book {
    
    var author: String = ""
    var title: String = ""
    var url: String = ""
    var id: Int = 0
    var categories: String?
    var publisher: String?
    var checkedOut: String?
    var checkedBy: String?
    
    init(data: [String:Any]) {
        if let author = data["author"] as? String {
            self.author = author
        }
        if let title = data["title"] as? String {
            self.title = title
        }
        if let url = data["url"] as? String {
            self.url = url
        }
        if let id = data["id"] as? Int {
            self.id = id
        }
        if let categories = data["categories"] as? String {
            self.categories = categories
        }
        if let publisher = data["publisher"] as? String {
            self.publisher = publisher
        }
        if let checkedOut = data["lastCheckedOut"] as? String {
            let checkedOutString = Date.prolificModify(checkedOut)
            self.checkedOut = checkedOutString
        }
        if let checkedBy = data["lastCheckedOutBy"] as? String {
            self.checkedBy = checkedBy
        }
    }
    
    //format strings for detailview
    func checkOutDescription() -> String {
        if let checkedOut = checkedOut,
            let checkedBy = checkedBy {
            return checkedBy + " @ " + checkedOut
        }
        return ""
    }
    
}
