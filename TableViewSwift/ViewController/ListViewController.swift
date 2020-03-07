//
//  ListViewController.swift
//  TableViewSwift
//
//  Created by Home on 3/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, Storyboarded, UITableViewDelegate, ListViewModelViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  var dataSource: DataSource<SubItem>?
  var viewModel: ListViewModel? {
    willSet {
      viewModel?.viewDelegate = nil
    }
    didSet {
      viewModel?.viewDelegate = self
    }
  }
    
    override func viewDidLoad() {
    super.viewDidLoad()
//        let contacts = [
//            Contact(name: "Rob",     phone: "555-1111"),
//            Contact(name: "Richard", phone: "555-2222"),
//            Contact(name: "Rachel",  phone: "555-1111"),
//            Contact(name: "Loren",   phone: "555-2222"),
//            Contact(name: "Mary",    phone: "555-3333"),
//            Contact(name: "Susie",   phone: "555-3333 \n  555-3333 \n 555-3333 \n 555-3333")
//        ]
    
    let data = listData
    dataSource = DataSource.make(for: data, reuseIdentifier: "fundTableViewCell")
    tableView.dataSource = dataSource
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 600
    tableView.reloadData()
    tableView.tableFooterView = UIView()
    }
    
    // MARK: Tableview Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      guard let item = dataSource?.models[indexPath.row] else {
        return
      }
      viewModel?.didSelect(item: item)
      }
    }
  
  struct Contact {
    let name: String
    let phone: String
}

