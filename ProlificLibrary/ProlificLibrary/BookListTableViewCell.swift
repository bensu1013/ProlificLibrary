//
//  BookListTableViewCell.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

protocol BookListCellDelegate {
    func deleteSelected()
}

class BookListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteButtonTrailing: NSLayoutConstraint!
    var vcDelegate: BookListCellDelegate?
    var deleteButtonHiding: Bool = true {
        didSet {
            deleteButtonHiding ? slideDeleteButtonRight() : slideDeleteButtonLeft()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        vcDelegate?.deleteSelected()
    }
    
    func setLabels(with book: Book) {
        backgroundColor = UIColor.clear
        deleteButtonHiding = true
        titleLabel.text = book.title
        authorLabel.text = book.author
    }
    
    func swipedEvent(_ direction: UISwipeGestureRecognizerDirection) {
        if direction == .left {
            deleteButtonHiding = false
        } else {
            deleteButtonHiding = true
        }
    }
    
    func slideDeleteButtonLeft() {
        UIView.animate(withDuration: 0.2) { 
            self.deleteButtonTrailing.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    func slideDeleteButtonRight() {
        UIView.animate(withDuration: 0.2) {
            self.deleteButtonTrailing.constant = -self.deleteButton.bounds.width * 2
            self.layoutIfNeeded()
        }
    }
    
}
