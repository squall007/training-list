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
    didSet {
      viewModel?.viewDelegate = self
    }
  }
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    let data = listData
    dataSource = DataSource.make(for: data, reuseIdentifier: "fundTableViewCell")
    tableView.dataSource = dataSource
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 600
    tableView.reloadData()
    tableView.tableFooterView = UIView()
  }
  
  func updateUIWithItem(itemSelected: Item) {
    if itemSelected.name.contains("MacBook") {
      let data = [
        SubItem(name: "Fund", detail: "Macbook"),
        SubItem(name: "To", detail: "Bank of America"),
        SubItem(name: "Amount", detail: "$2,300"),
        SubItem(name: "Year", detail: "2015"),
      ]
      dataSource = DataSource.make(for: data, reuseIdentifier: "fundTableViewCell")
    } else {
      dataSource = DataSource.make(for: listData, reuseIdentifier: "fundTableViewCell")
    }
    tableView.dataSource = dataSource
    tableView.reloadData()
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

