//
//  DetailListViewController.swift
//  TableViewSwift
//
//  Created by Home on 3/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class DetailListViewController: UIViewController, Storyboarded, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  var dataSource: SectionedTableViewDataSource?

  override func viewDidLoad() {
    super.viewDidLoad()
//    let dataSource = SectionedTableViewDataSource(dataSources: [
//        TableViewDataSource.make(for: recentContacts),
//        TableViewDataSource.make(for: topMessages)
//    ])
//    tableView.dataSource = dataSource
    let sectionDataSource = sectionsData.map { (section) -> DataSource<Item> in
      let aSource = DataSource.make(for: section.items, reuseIdentifier: "rowCell")
      return aSource
    }
    print(sectionDataSource)
    dataSource = SectionedTableViewDataSource(dataSources: sectionDataSource)
    tableView.dataSource = dataSource
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 600
    tableView.reloadData()
    tableView.tableFooterView = UIView()
    
  }
  
  // MARK: Tableview Delegate
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    guard let item = dataSource?.models[indexPath.row] else {
//      return
//    }
//    viewModel?.didSelect(item: item)
//    }
//  }
}
