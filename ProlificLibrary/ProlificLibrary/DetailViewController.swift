//
//  DetailViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var checkOutLabel: UILabel!
    var book: Book!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProlificAPI.getBook(bookURL: self.book.url, completion: { (book) in
            self.book = book
            DispatchQueue.main.async {
                self.prepareLabels()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UpdateBookViewController {
            dest.book = self.book
            dest.delegate = self
        }
    }

    deinit {
        print("bye bye detail")
    }
    
    func prepareLabels() {
        titleLabel.text = book.title
        authorLabel.text = book.author
        publisherLabel.text = book.publisher
        tagsLabel.text = book.categories
        checkOutLabel.text = book.checkOutDescription()
    }
    
    @IBAction func checkingOut(_ sender: UIButton) {
        let alert = UIAlertController(title: "Checking Out", message: "Please Enter Your Name", preferredStyle: .alert)
        alert.addTextField()
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { (action) in
            if let name = alert.textFields?[0].text {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
                let timeCheckedOut = dateFormatter.string(from: Date())
                let checkOutData = ["lastCheckedOut": timeCheckedOut,
                                    "lastCheckedOutBy": name]
                ProlificAPI.updateBook(bookURL: self.book.url, update: checkOutData, completion: { (completed) in
                    ProlificAPI.getBook(bookURL: self.book.url, completion: { (book) in
                        self.book = book
                        DispatchQueue.main.async {
                            self.prepareLabels()
                        }
                    })
                })
            }
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true) {
        }
    }

    @IBAction func sharing(_ sender: UIBarButtonItem) {
        let shareAlert = UIAlertController(title: "The World Must See", message: "", preferredStyle: .actionSheet)
        let facebookAction = UIAlertAction(title: "Facebook", style: .default) { (action) in
            if let vc = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                vc.setInitialText("\(self.book.title) is a great read")
                self.present(vc, animated: true)
            }
        }
        let twitterAction = UIAlertAction(title: "Twitter", style: .default) { (action) in
            if let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
                vc.setInitialText("\(self.book.title) is a great read")
                self.present(vc, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        shareAlert.addAction(facebookAction)
        shareAlert.addAction(twitterAction)
        shareAlert.addAction(cancelAction)
        present(shareAlert, animated: true)
    }
}

extension DetailViewController: UpdateBookVCDelegate {
    
    func dimissDetailView() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
