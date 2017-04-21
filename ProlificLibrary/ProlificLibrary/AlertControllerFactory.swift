//
//  AlertControllerFactory.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/20/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Foundation
import UIKit
import Social

enum SubmitAlertMessage: String {
    case add = "No title and author, what are you trying to do?"
    case update = "You claim to change, but none was written."
}

struct AlertControllerFactory {
    
    static func createSearching(handler: @escaping () -> () ) -> UIAlertController {
        let searchAlert = UIAlertController(title: nil, message: "What would you like to inquiry?", preferredStyle: .alert)
        searchAlert.addTextField(configurationHandler: nil)
        let cancelAction = UIAlertAction(title: "Nevermind", style: .cancel, handler: nil)
        let searchTitleAction = UIAlertAction(title: "Search by Title", style: .default) { (action) in
            if let searchText = searchAlert.textFields?[0].text {
                if searchText != "" {
                    print("title")
                    BookManager.main.searchTitles(for: searchText)
                    handler()
                }
            }
        }
        let searchAuthorAction = UIAlertAction(title: "Search by Author", style: .default) { (action) in
            if let searchText = searchAlert.textFields?[0].text {
                if searchText != "" {
                    BookManager.main.searchAuthors(for: searchText)
                    handler()
                }
            }
        }
        let clearSearch = UIAlertAction(title: "Show It All!", style: .default) { (action) in
            BookManager.main.clearSearch()
            handler()
        }
        searchAlert.addAction(cancelAction)
        searchAlert.addAction(searchTitleAction)
        searchAlert.addAction(searchAuthorAction)
        searchAlert.addAction(clearSearch)
        return searchAlert
    }
    
    static func createBookpocalypse(handler: @escaping () -> () ) -> UIAlertController {
        let deathAlert = UIAlertController(title: "The End is Near", message: "The great fires of Alexandria will pale in comparison!", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Retreat", style: .cancel)
        let confirm = UIAlertAction(title: "Burn", style: .destructive) { (action) in
            BookManager.main.bookpocalypse {
                handler()
            }
        }
        deathAlert.addAction(cancel)
        deathAlert.addAction(confirm)
        return deathAlert
    }
    
    static func createCheckingOut(handler: @escaping () -> () ) -> UIAlertController {
        let checkOutAlert = UIAlertController(title: "You wish to borrow?", message: "Please scribe your name.", preferredStyle: .alert)
        checkOutAlert.addTextField()
        let cancel = UIAlertAction(title: "Nevermind", style: .cancel)
        let confirm = UIAlertAction(title: "Finished", style: .default) { (action) in
            if let name = checkOutAlert.textFields?[0].text {
                let currentTime = Date.prolificCurrentTime()
                let checkOutData = ["lastCheckedOut": currentTime,
                                    "lastCheckedOutBy": name]
                BookManager.main.checkOutSelectedBook(with: checkOutData, handler: { 
                    handler()
                })
            }
        }
        checkOutAlert.addAction(cancel)
        checkOutAlert.addAction(confirm)
        return checkOutAlert
    }
    
    static func createSharing(handler: @escaping (SLComposeViewController) -> () ) -> UIAlertController {
        let shareAlert = UIAlertController(title: nil, message: "You wish to share with your fellow scholars?", preferredStyle: .actionSheet)
        let facebookAction = UIAlertAction(title: "Book of Faces", style: .default) { (action) in
            if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                handler(vc)
            }
        }
        let twitterAction = UIAlertAction(title: "Chirper", style: .default) { (action) in
            if let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
                handler(vc)
            }
        }
        let cancelAction = UIAlertAction(title: "Nevermind", style: .cancel, handler: nil)
        shareAlert.addAction(facebookAction)
        shareAlert.addAction(twitterAction)
        shareAlert.addAction(cancelAction)
        return shareAlert
    }
    
    //When submitting with incomplete required data, enum above for personalized message
    static func createSubmit(as message: SubmitAlertMessage) -> UIAlertController {
        let title = "Insufficient Scrawl"
        let message = message.rawValue
        let doneAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "I Understand", style: .cancel)
        doneAlert.addAction(confirm)
        return doneAlert
    }
    
    static func createDone(handler: @escaping () -> () ) -> UIAlertController {
        let alert = UIAlertController(title: "Leaving?", message: "Incomplete drafts will be disposed of.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Nevermind", style: .cancel)
        alert.addAction(cancel)
        let confirm = UIAlertAction(title: "Dispose", style: .default) { (action) in
            handler()
        }
        alert.addAction(confirm)
        return alert
    }
    
    static func createDelete(handler: @escaping () -> () ) -> UIAlertController {
        let alertTitle = "Pilfer?"
        let alertMessage = "You dare remove this book from the Prolific Library?\nHow could you fathom such a thing?"
        let deleteAlert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Nevermind", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Yoink!", style: .destructive) { (action) in
            BookManager.main.deleteSelectedBook {
                handler()
            }
        }
        deleteAlert.addAction(cancelAction)
        deleteAlert.addAction(confirmAction)
        return deleteAlert
    }
    
}

