//
//  TextManipulator.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/23/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation

class TextManipulator {
    
    static func capitalizeWords(in text: String) -> String {
        var result = ""
        let words = text.lowercased().components(separatedBy: " ")
        for word in words {
            result += word.capitalized + " "
        }
        result = String(result.characters.dropLast())
        return result
    }
    
}
