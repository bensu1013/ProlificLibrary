//
//  UpdateBookViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/18/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

final class UpdateBookViewController: UIViewController {

    @IBOutlet weak var textFieldStackView: UIStackView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    @IBOutlet weak var stackViewYAxisConstraint: NSLayoutConstraint!
    @IBOutlet weak var submitButton: UIButton!
    //checks if any textfields has text
    private var fieldsHasText: Bool {
        return titleTextField.hasText || authorTextField.hasText ||
            publisherTextField.hasText || categoriesTextField.hasText ? true : false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    //used for resigning keyboard
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: view)
            if !textFieldStackView.frame.contains(point) {
                view.endEditing(true)
            }
        }
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        if fieldsHasText {
            presentDoneAlert()
        } else {
            dismiss(animated: true)
        }
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
    
    //setting subview fonts and sizes
    private func prepareTextFields() {
        titleTextField.delegate = self
        titleTextField.layer.cornerRadius = titleTextField.frame.height / 5
        titleTextField.layer.borderWidth = 2
        titleTextField.font = UIFont.themedFont(as: .Regular)
        authorTextField.delegate = self
        authorTextField.layer.cornerRadius = titleTextField.frame.height / 5
        authorTextField.layer.borderWidth = 2
        authorTextField.font = UIFont.themedFont(as: .Regular)
        publisherTextField.delegate = self
        publisherTextField.layer.cornerRadius = titleTextField.frame.height / 5
        publisherTextField.layer.borderWidth = 2
        publisherTextField.font = UIFont.themedFont(as: .Regular)
        categoriesTextField.delegate = self
        categoriesTextField.layer.cornerRadius = titleTextField.frame.height / 5
        categoriesTextField.layer.borderWidth = 2
        categoriesTextField.font = UIFont.themedFont(as: .Regular)
        submitButton.layer.cornerRadius = submitButton.frame.height / 3
        submitButton.layer.borderWidth = 2
        submitButton.titleLabel?.font = UIFont.themedFont(as: .Regular)
    }
    
    //Fill labels with info from selectedBook
    func setLabels() {
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
    
    //wrapper method to send to api methods
    private func packageBookData() -> [String: Any] {
        var bookData = [String: Any]()
        if titleTextField.hasText {
            bookData["title"] = titleTextField.text?.capitalized
        }
        if authorTextField.hasText {
            bookData["author"] = authorTextField.text?.capitalized
        }
        if publisherTextField.hasText {
            bookData["publisher"] = publisherTextField.text?.capitalized
        }
        if categoriesTextField.hasText {
            bookData["categories"] = categoriesTextField.text?.capitalized
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

//MARK: TextFieldDelegate
extension UpdateBookViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        stackViewYAxisConstraint.isActive = false
        let newYConstraint = NSLayoutConstraint(item: textFieldStackView,
                                                attribute: .centerYWithinMargins,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .centerY,
                                                multiplier: 0.55,
                                                constant: 0)
        UIView.animate(withDuration: 0.25) {
            self.stackViewYAxisConstraint = newYConstraint
            self.stackViewYAxisConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        stackViewYAxisConstraint.isActive = false
        let newYConstraint = NSLayoutConstraint(item: textFieldStackView,
                                                attribute: .centerYWithinMargins,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: .centerY,
                                                multiplier: 0.8,
                                                constant: 0)
        UIView.animate(withDuration: 0.25) {
            self.stackViewYAxisConstraint = newYConstraint
            self.stackViewYAxisConstraint.isActive = true
            self.view.layoutIfNeeded()
        }
    }
    
}
