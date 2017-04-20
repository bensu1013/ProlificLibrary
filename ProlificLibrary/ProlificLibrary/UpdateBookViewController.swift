//
//  UpdateBookViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/18/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

protocol UpdateBookVCDelegate {
    func dimissDetailView()
}

class UpdateBookViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    
//    var book: Book!
    var delegate: UpdateBookVCDelegate!
    
    private var fieldsHasText: Bool {
        return titleTextField.hasText || authorTextField.hasText ||
            publisherTextField.hasText || categoriesTextField.hasText ? true : false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareLabels()
    }
    
    func prepareLabels() {
        guard let book = BookManager.main.selectedBook else {
            return
        }
        titleTextField.placeholder = "Title: " + book.title
        authorTextField.placeholder = "Author: " + book.author
        if let publisher = book.publisher {
            publisherTextField.placeholder = "Publisher: " + publisher
        } else {
            publisherTextField.placeholder = "Publisher: N/A"
        }
        if let tags = book.categories {
            categoriesTextField.placeholder = "Tags: " + tags
        } else {
            categoriesTextField.placeholder = "Tags: N/A"
        }
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        if fieldsHasText {
            presentDoneAlert()
        } else {
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        let deleteAlert = AlertControllerFactory.createDelete {
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
                self.delegate.dimissDetailView()
            }
        }
        self.present(deleteAlert, animated: true)
    }
    
    
    @IBAction func submitButtonAction(_ sender: UIButton) {
        if fieldsHasText {
            let bookData = packageBookData()
            BookManager.main.updateSelectedBook(with: bookData, handler: { 
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            presentSubmitAlert()
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
        let submitAlert = AlertControllerFactory.createSubmit(as: .update)
        present(submitAlert, animated: true, completion: nil)
    }
    
    private func presentDoneAlert() {
        let doneAlert = AlertControllerFactory.createDone {
            self.dismiss(animated: true, completion: nil)
        }
        present(doneAlert, animated: true, completion: nil)
    }
    
}
