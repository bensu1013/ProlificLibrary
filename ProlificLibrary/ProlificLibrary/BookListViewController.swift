//
//  ViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let bookManager = BookManager.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height / 8
        let recognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        recognizer.direction = .left
        tableView.addGestureRecognizer(recognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookManager.loadBooks {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = segue.destination as? DetailViewController,
            let index = tableView.indexPathForSelectedRow {
            bookManager.select(at: index.row)
        }
    }
    
    @IBAction func searchButtonAction(_ sender: UIBarButtonItem) {
        let searchAlert = AlertControllerFactory.createSearching {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        present(searchAlert, animated: true)
    }
    
    @IBAction func bookpocalypse(_ sender: UIButton) {
        let deathAlert = AlertControllerFactory.createBookpocalypse {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        present(deathAlert, animated: true)
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        var recognizer = UISwipeGestureRecognizer(target: self, action: "didSwipe")
//        self.tableView.addGestureRecognizer(recognizer)
//    }
    
    func didSwipe(recognizer: UIGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
            let swipeLocation = recognizer.location(in: self.tableView)
            if let swipedIndexPath = tableView.indexPathForRow(at: swipeLocation) {
                if let swipedCell = self.tableView.cellForRow(at: swipedIndexPath) as? BookListTableViewCell {
                    swipedCell.setSelected(false, animated: true)
//                    bookManager.select(at: swipedIndexPath.row)
//                    let deleteAlert = AlertControllerFactory.createDelete {
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }
//                    self.present(deleteAlert, animated: true)
                }
            }
        }
    }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookManager.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListCell", for: indexPath) as! BookListTableViewCell
        let book = bookManager.list[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author
        return cell
    }
    
}
