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
        for cell in tableView.visibleCells {
            shakeAnimation(for: cell)
        }
        let deathAlert = AlertControllerFactory.createBookpocalypse {
            DispatchQueue.main.async {
                for cell in self.tableView.visibleCells {
                    self.stopAnimation(for: cell)
                }
                self.tableView.reloadData()
                
            }
        }
        present(deathAlert, animated: true)
    }
    
    //Selector method for swipegestures
    func didSwipe(recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == UIGestureRecognizerState.ended {
            let swipeLocation = recognizer.location(in: tableView)
            if let swipedIndexPath = tableView.indexPathForRow(at: swipeLocation),
                let swipedCell = tableView.cellForRow(at: swipedIndexPath) as? BookListTableViewCell {
                swipedCell.swipedEvent(recognizer.direction)
            }
        }
    }
    
    fileprivate func shakeAnimation(for cell: UITableViewCell) {
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
                cell.transform = CGAffineTransform.init(rotationAngle: 0.05)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                cell.transform = CGAffineTransform.init(rotationAngle: -0.05)
            })
        }, completion: nil)
    }
    
    fileprivate func stopAnimation(for cell: UITableViewCell) {
        cell.layer.removeAllAnimations()
        cell.transform = CGAffineTransform.identity
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UIScreen.main.bounds.height / 8
    }
    
    private func prepareGestureRecognizers() {
        let leftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        leftRecognizer.direction = .left
        tableView.addGestureRecognizer(leftRecognizer)
        let rightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        rightRecognizer.direction = .right
        tableView.addGestureRecognizer(rightRecognizer)
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
    func deleteSelected(for cell: UITableViewCell) {
        shakeAnimation(for: cell)
        let deleteAlert = AlertControllerFactory.createDelete {
            DispatchQueue.main.async {
                self.stopAnimation(for: cell)
                self.tableView.reloadData()
            }
        }
        present(deleteAlert, animated: true)
    }
    
}
