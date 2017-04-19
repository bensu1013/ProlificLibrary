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
        if let dest = segue.destination as? DetailViewController,
            let index = tableView.indexPathForSelectedRow {
            let chosenBook = bookManager.list[index.row]
            dest.book = chosenBook
        }
    }
    
    @IBAction func searchButtonAction(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func bookpocalypse(_ sender: UIButton) {
        let deathAlert = UIAlertController(title: "The End is Near", message: "The great fires of Alexandria will pale in comparison!", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Retreat", style: .cancel)
        let confirm = UIAlertAction(title: "Burn", style: .destructive) { (action) in
            ProlificAPI.deleteAllBooks(completion: { (completed) in
                DispatchQueue.main.async {
                    self.bookManager.list.removeAll()
                    self.tableView.reloadData()
                }
            })
        }
        deathAlert.addAction(cancel)
        deathAlert.addAction(confirm)
        self.present(deathAlert, animated: true)
    }
    
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookManager.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookListCell", for: indexPath)
        let book = bookManager.list[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.author
        return cell
    }
    
}
