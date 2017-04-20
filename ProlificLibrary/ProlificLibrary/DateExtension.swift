//
//  DateExtension.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/20/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

extension Date {
    
    static func prolificCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
        let currentTime = dateFormatter.string(from: Date())
        return currentTime
    }
    
    static func prolificModify(_ time: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "GST")
        guard let date = dateFormatter.date(from: time) else {
            return nil
        }
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let newTime = dateFormatter.string(from: date)
        return newTime
    }
    
}
