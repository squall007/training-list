//
//  OverlayViewController.swift
//  TableViewSwift
//
//  Created by Home on 3/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController, Storyboarded {
  @IBOutlet weak var tableView: UITableView!
  var dataSource: DataSource<Bank>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let banks = [
      Bank(name: "Capital One",     number: "555-1111"),
      Bank(name: "Chase", number: "555-2222"),
      Bank(name: "TD Bank",  number: "555-1111"),
      Bank(name: "PNC",   number: "555-2222"),
      Bank(name: "Schwab",    number: "555-3333"),
      Bank(name: "Wells Fargo",   number: "555-3333 \n  555-3333 \n 555-3333 \n 555-3333")
    ]
    
    dataSource = DataSource.make(for: banks, reuseIdentifier: "sourceIdentifier")
    tableView.dataSource = dataSource
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 600
    tableView.reloadData()
    tableView.tableFooterView = UIView()
  }
}

struct Bank {
  let name: String
  let number: String
}
