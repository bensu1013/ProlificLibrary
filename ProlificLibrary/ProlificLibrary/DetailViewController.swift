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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BookManager.main.refreshSelectedBook {
            DispatchQueue.main.async {
                self.prepareLabels()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UpdateBookViewController {
//            dest.book = self.book
            dest.delegate = self
        }
    }
    
    func prepareLabels() {
        guard let book = BookManager.main.selectedBook else {
            return
        }
        titleLabel.text = book.title
        authorLabel.text = book.author
        publisherLabel.text = book.publisher
        tagsLabel.text = book.categories
        checkOutLabel.text = book.checkOutDescription()
    }
    
    @IBAction func checkingOut(_ sender: UIButton) {
        let checkOutAlert = AlertControllerFactory.createCheckingOut() {
            DispatchQueue.main.async {
                self.prepareLabels()
            }
        }
        present(checkOutAlert, animated: true)
    }

    @IBAction func sharing(_ sender: UIBarButtonItem) {
        guard let book = BookManager.main.selectedBook else {
            return
        }
        let shareAlert = AlertControllerFactory.createSharing { (vc) in
            vc.setInitialText("\(book.title) is a great read")
            self.present(vc, animated: true)
        }
        present(shareAlert, animated: true)
    }
}

extension DetailViewController: UpdateBookVCDelegate {
    
    func dimissDetailView() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
