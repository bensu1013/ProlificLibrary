//
//  AddBookViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {

    
    @IBOutlet weak var doneButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let testBook = [
            "author": "Grandolf The Pure",
            "categories": "Elfotica",
            "title": "50 Shades of Bilbo",
            "publisher": "Shirelastics",
        ]
        ProlificAPI.addNew(testBook) { (completed) in
            print("nice")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) { 
            
        }
    }

}
