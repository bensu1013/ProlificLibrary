//
//  ViewController.swift
//  ProlificLibrary
//
//  Created by Benjamin Su on 4/17/17.
//  Copyright © 2017 Benjamin Su. All rights reserved.
//

import UIKit

final class BookListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let bookManager = BookManager.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareGestureRecognizers()
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
    
    //Search options through the use of uialert
    @IBAction func searchButtonAction(_ sender: UIBarButtonItem) {
        let searchAlert = AlertControllerFactory.createSearching {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        present(searchAlert, animated: true)
    }
    
    //Hidden option to delete all books in the library
    @IBAction func bookpocalypse(_ sender: UIButton) {
        let deathAlert = AlertControllerFactory.createBookpocalypse {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        present(deathAlert, animated: true)
    }
    
    //Selector method for swipegestures
    func didSwipe(recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
            let swipeLocation = recognizer.location(in: self.tableView)
            if let swipedIndexPath = tableView.indexPathForRow(at: swipeLocation),
                let swipedCell = self.tableView.cellForRow(at: swipedIndexPath) as? BookListTableViewCell {
                swipedCell.swipedEvent(recognizer.direction)
            }
        }
    }
    
    private func prepareGestureRecognizers() {
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        leftRecognizer.direction = .left
        tableView.addGestureRecognizer(leftRecognizer)
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        rightRecognizer.direction = .right
        tableView.addGestureRecognizer(rightRecognizer)
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height / 8
    }
    
}

//MARK: Tableview methods
extension BookListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookManager.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListCell", for: indexPath) as! BookListTableViewCell
        let book = bookManager.list[indexPath.row]
        cell.setLabels(with: book)
        cell.vcDelegate = self
        return cell
    }
    
}

extension BookListViewController: BookListCellDelegate {
    
    //When delete button in cell is pressed
    func deleteSelected() {
        let deleteAlert = AlertControllerFactory.createDelete {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.present(deleteAlert, animated: true)
    }
    
}
