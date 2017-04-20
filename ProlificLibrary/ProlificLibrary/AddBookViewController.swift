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
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        if fieldsHasText {
            presentDoneAlert()
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if !titleTextField.hasText || !authorTextField.hasText {
            presentSubmitAlert()
        } else {
            let bookData = packageBookData()
            BookManager.main.addNewBook(with: bookData, handler: { 
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    private func packageBookData() -> [String: Any] {
        var bookData = [String: Any]()
        if titleTextField.hasText {
            bookData["title"] = titleTextField.text
        }
        if authorTextField.hasText {
            bookData["author"] = authorTextField.text
        }
        if publisherTextField.hasText {
            bookData["publisher"] = publisherTextField.text
        }
        if categoriesTextField.hasText {
            bookData["categories"] = categoriesTextField.text
        }
        return bookData
    }
    
    private func presentSubmitAlert() {
        let submitAlert = AlertControllerFactory.createSubmit(as: .add)
        present(submitAlert, animated: true, completion: nil)
    }
    
    private func presentDoneAlert() {
        let doneAlert = AlertControllerFactory.createDone {
            self.dismiss(animated: true, completion: nil)
        }
        present(doneAlert, animated: true, completion: nil)
    }
    
}
