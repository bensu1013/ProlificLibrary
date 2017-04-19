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
    
    @IBOutlet weak var categoriesTextField: UITextField!
    
    private var fieldsHasText: Bool {
        return titleTextField.hasText ||
            authorTextField.hasText ||
            publisherTextField.hasText ||
            categoriesTextField.hasText ? true : false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        if fieldsHasText {
            showDoneAlert()
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if !titleTextField.hasText || !authorTextField.hasText {
            showSubmitAlert()
        } else {
            let bookData: [String: String?] = ["title": titleTextField.text,
                            "author": authorTextField.text,
                            "publisher": publisherTextField.text,
                            "categories": categoriesTextField.text]
            ProlificAPI.addNew(bookData, completion: { (completed) in
                if completed {
                    self.dismiss(animated: true)
                }
            })
        }
    }
    
    private func showSubmitAlert() {
        let alert = UIAlertController(title: "Need More Info", message: "Both Title and Author of the book is required to submit!", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Okay", style: .cancel)
        alert.addAction(confirm)
        self.show(alert, sender: nil)
    }
    
    private func showDoneAlert() {
        let alert = UIAlertController(title: "You Sure?", message: "Unsubmitted text will be lost.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        let confirm = UIAlertAction(title: "Okay", style: .default) { (action) in
            self.dismiss(animated: true)
        }
        alert.addAction(confirm)
        self.show(alert, sender: nil)
    }
    
}
