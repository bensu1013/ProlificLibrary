//
//  AddBookViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

final class AddBookViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textFieldStackView: UIStackView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var categoriesTextField: UITextField!
    @IBOutlet weak var stackViewYAxisConstraint: NSLayoutConstraint!
    @IBOutlet weak var submitButton: UIButton!
    private var fieldsHasText: Bool {
        return titleTextField.hasText ||
            authorTextField.hasText ||
            publisherTextField.hasText ||
            categoriesTextField.hasText ? true : false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTextFields()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
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
        if !titleTextField.hasText || !authorTextField.hasText {
            presentSubmitAlert()
        } else {
            let bookData = packageBookData()
            BookManager.main.addNewBook(with: bookData, handler: { 
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    private func prepareTextFields() {
        titleTextField.delegate = self
        titleTextField.font = UIFont.themedFont(as: .Regular)
        authorTextField.delegate = self
        authorTextField.font = UIFont.themedFont(as: .Regular)
        publisherTextField.delegate = self
        publisherTextField.font = UIFont.themedFont(as: .Regular)
        categoriesTextField.delegate = self
        categoriesTextField.font = UIFont.themedFont(as: .Regular)
        submitButton.titleLabel?.font = UIFont.themedFont(as: .Regular)
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

//MARK: TextFieldDelegate
extension AddBookViewController: UITextFieldDelegate {
    
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
