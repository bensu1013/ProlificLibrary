//
//  FontExtension.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/22/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit

//used for UIFont to set font sizes for themeFont method
internal enum FontType {
    
    case Title
    case Author
    case Regular
    case Small
    
    func size() -> CGFloat {
        switch self {
        case .Title:
            return (UIScreen.main.bounds.height / 20)
        case .Author:
            return (UIScreen.main.bounds.height / 25)
        case .Regular:
            return (UIScreen.main.bounds.height / 30)
        case .Small:
            return (UIScreen.main.bounds.height / 34)
        }
    }
    
}

//method for setting fonts to a theme with choice of scaling fontsizes
extension UIFont {
    
    static func themedFont(name: String = "Georgia", as type: FontType) -> UIFont? {
        let font = UIFont(name: name, size: type.size())
        return font
    }
    
}
