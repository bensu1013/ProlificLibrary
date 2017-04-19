//
//  UpdateBookViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/18/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class UpdateBookViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var authorTextField: UITextField!
    
    @IBOutlet weak var publisherTextField: UITextField!
    
    @IBOutlet weak var categoriesTextField: UITextField!
    
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareLabels()
        
    }
    
    func prepareLabels() {
        titleTextField.placeholder = book.title
        authorTextField.placeholder = book.author
        publisherTextField.placeholder = book.publisher
        categoriesTextField.placeholder = book.categories
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        
        let deleteAlert = UIAlertController(title: "Delete?", message: "You are about to remove this book from the Prolific Library permanently./nAre you sure?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            ProlificAPI.deleteBook(bookURL: self.book.url, completion: { (complete) in
                self.presentingViewController!.dismiss(animated: true, completion: nil)
            })
        }
        deleteAlert.addAction(cancelAction)
        deleteAlert.addAction(confirmAction)
        self.present(deleteAlert, animated: true) { 
            
        }
    }
    
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
    }

}
