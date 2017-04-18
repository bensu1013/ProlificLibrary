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
    
    var book: Book!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = book.title
        authorLabel.text = book.author
        publisherLabel.text = book.publisher
        tagsLabel.text = book.categories
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func checkingOut(_ sender: UIButton) {
    }

    @IBAction func sharing(_ sender: UIBarButtonItem) {
        
    }
    
    
}
