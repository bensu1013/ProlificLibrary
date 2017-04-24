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
    @IBOutlet weak var publisherHeader: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var tagsHeader: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var checkOutHeader: UILabel!
    @IBOutlet weak var checkOutLabel: UILabel!
    @IBOutlet weak var checkOutButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLabels()
    }
    
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
    
    //setting subview fonts and sizes
    private func prepareLabels() {
        titleLabel.font = UIFont.themedFont(as: .Title)
        authorLabel.font = UIFont.themedFont(as: .Author)
        publisherHeader.font = UIFont.themedFont(as: .Regular)
        publisherLabel.font = UIFont.themedFont(as: .Regular)
        tagsHeader.font = UIFont.themedFont(as: .Regular)
        tagsLabel.font = UIFont.themedFont(as: .Regular)
        checkOutHeader.font = UIFont.themedFont(as: .Regular)
        checkOutLabel.font = UIFont.themedFont(as: .Regular)
        checkOutButton.layer.cornerRadius = checkOutButton.frame.height / 3
        checkOutButton.layer.borderWidth = 2
        checkOutButton.titleLabel?.font = UIFont.themedFont(as: .Small)
        shareButton.layer.cornerRadius = shareButton.frame.height / 3
        shareButton.layer.borderWidth = 2
        shareButton.titleLabel?.font = UIFont.themedFont(as: .Small)
    }
    
    //Fill labels with info from selectedBook
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
