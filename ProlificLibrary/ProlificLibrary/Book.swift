//
//  Book.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class Book {
    
    var author:     String = ""
    var title:      String = ""
    var url:        String?
    var id:         Int?
    var categories: String?
    var publisher:  String?
    var checkedOut: String?
    var checkedBy:  String?
    
    init(data: [String:Any]) {
        if let author = data["author"] as? String {
            self.author = author
        }
        if let title = data["title"] as? String {
            self.title = title
        }
    }
    
}
