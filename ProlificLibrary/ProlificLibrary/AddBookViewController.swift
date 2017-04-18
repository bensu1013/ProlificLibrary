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
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    @IBOutlet weak var publisherTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) { 
            
        }
    }
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if titleTextField.text == "" || authorTextField.text == "" {
            
        } else {
            let bookData: [String: Any] = ["title": titleTextField.text,
                            "author": authorTextField.text,
                            "publisher": publisherTextField.text,
                            "categories": categoryTextField.text]
            ProlificAPI.addNew(bookData, completion: { (completed) in
                if completed {
                    self.dismiss(animated: true, completion: { 
                        
                    })
                }
            })
        }
    }
    
}
