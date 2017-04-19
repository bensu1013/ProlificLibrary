//
//  DetailViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var checkOutLabel: UILabel!
    
    var book: Book!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ProlificAPI.getBook(bookURL: self.book.url, completion: { (book) in
            self.book = book
            DispatchQueue.main.async {
                self.prepareLabels()
            }
            
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UpdateBookViewController {
            dest.book = self.book
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
        let confirm = UIAlertAction(title: "Confirm", style: .default) { (action) in
            if let name = alert.textFields?[0].text {
       
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
                
                
                let timeCheckedOut = dateFormatter.string(from: Date())
                print(timeCheckedOut)
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
        alert.addAction(confirm)
        self.present(alert, animated: true) { 
            
        }
    }

    @IBAction func sharing(_ sender: UIBarButtonItem) {
        
    }
    
    
}
