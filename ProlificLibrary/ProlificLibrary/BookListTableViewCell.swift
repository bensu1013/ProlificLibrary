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
    var vcDelegate: BookListCellDelegate?
    
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
        deleteButton.isHidden = true
        titleLabel.text = book.title
        authorLabel.text = book.author
    }
    
    func swipedEvent() {
        deleteButton.isHidden = !deleteButton.isHidden
    }
    
}
