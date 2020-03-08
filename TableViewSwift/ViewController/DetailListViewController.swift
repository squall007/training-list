//
//  DetailListViewController.swift
//  TableViewSwift
//
//  Created by Home on 3/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import UIKit

class DetailListViewController: UIViewController, Storyboarded, UITableViewDelegate, DetailListViewModelViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  var dataSource: SectionedTableViewDataSource?
  var viewModel: DetailListViewModel? {
    willSet {
      viewModel?.listVMViewDelegate = self
    }
  }
  
  // MARK: View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    let sectionDataSource = sectionsData.map { (section) -> DataSource<Item> in
      let aSource = DataSource.make(for: section.items, reuseIdentifier: "rowCell")
      return aSource
    }
    let headerArray = sectionsData.map { $0.name }
    print(sectionDataSource)
    dataSource = SectionedTableViewDataSource(dataSources: sectionDataSource)
    dataSource?.headers = headerArray
    tableView.dataSource = dataSource
    tableView.delegate = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 600
    tableView.reloadData()
    tableView.tableFooterView = UIView()
  }
  
  // MARK: Tableview Delegate methods
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableCell(withIdentifier: "headerCell")
    return headerView
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let section = dataSource?.dataSources[indexPath.section] as! DataSource<Item>
    let model = section.models[indexPath.row]
    viewModel?.detailListViewModeldidSelect(item: model)
    print(model)
  }
}
