//
//  DetailViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import Social
import UIKit

final class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var checkOutLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BookManager.main.refreshSelectedBook {
            DispatchQueue.main.async {
                self.setLabels()
            }
        }
    }
    
    @IBAction func checkingOut(_ sender: UIButton) {
        let checkOutAlert = AlertControllerFactory.createCheckingOut() {
            DispatchQueue.main.async {
                self.setLabels()
            }
        }
        present(checkOutAlert, animated: true)
    }

    @IBAction func sharing(_ sender: UIButton) {
        guard let book = BookManager.main.selectedBook else {
            return
        }
        let shareAlert = AlertControllerFactory.createSharing { (vc) in
            vc.setInitialText("\(book.title) is a great read!")
            self.present(vc, animated: true)
        }
        present(shareAlert, animated: true)
    }
    
    private func setLabels() {
        guard let book = BookManager.main.selectedBook else {
            return
        }
        titleLabel.text = book.title
        authorLabel.text = book.author
        if let publisher = book.publisher {
            publisherLabel.text = publisher
        } else {
            publisherLabel.text = "N/A"
        }
        if let categories = book.categories {
            tagsLabel.text = categories
        } else {
            tagsLabel.text = "N/A"
        }
        checkOutLabel.text = book.checkOutDescription()
    }
    
}
