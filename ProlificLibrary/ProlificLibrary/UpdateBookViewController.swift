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
    
    private var fieldsHasText: Bool {
        return titleTextField.hasText || authorTextField.hasText ||
            publisherTextField.hasText || categoriesTextField.hasText ? true : false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareLabels()
        
    }
    
    deinit {
        print("bye bye update")
    }
    
    func prepareLabels() {
        titleTextField.placeholder = book.title
        authorTextField.placeholder = book.author
        publisherTextField.placeholder = book.publisher
        categoriesTextField.placeholder = book.categories
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        if fieldsHasText {
            showDoneAlert()
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        
        let deleteAlert = UIAlertController(title: "Delete?", message: "You are about to remove this book from the Prolific Library permanently.\nAre you sure?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            ProlificAPI.deleteBook(bookURL: self.book.url, completion: { (complete) in
                DispatchQueue.main.async {
                    self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                }
                
            })
        }
        deleteAlert.addAction(cancelAction)
        deleteAlert.addAction(confirmAction)
        self.present(deleteAlert, animated: true)
    }
    
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if fieldsHasText {
            let bookData = packageBookData()
            ProlificAPI.updateBook(bookURL: self.book.url, update: bookData, completion: { (completed) in
                self.dismiss(animated: true)
            })
        } else {
            showSubmitAlert()
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
    
    private func showSubmitAlert() {
        let alert = UIAlertController(title: "", message: "No updates were made to the book.", preferredStyle: .alert)
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
