//
//  DataSource.swift
//  TableViewSwift
//
//  Created by Home on 3/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

// MARK: Data Source Implementation
class DataSource<Model>: NSObject, UITableViewDataSource {
  typealias CellConfigurator = (Model, UITableViewCell) -> Void
  var models: [Model]
  
  private let reuseIdentifier: String
  private let cellConfigurator: CellConfigurator
  
  init(models: [Model],
       reuseIdentifier: String,
       cellConfigurator: @escaping CellConfigurator) {
    self.models = models
    self.reuseIdentifier = reuseIdentifier
    self.cellConfigurator = cellConfigurator
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = models[indexPath.row]
    let cell = tableView.dequeueReusableCell(
      withIdentifier: reuseIdentifier,
      for: indexPath
    )
    cellConfigurator(model, cell)
    return cell
  }
}

// MARK: Data Source Extensions
extension DataSource where Model == Bank {
  static func make(for banks: [Bank],
                   reuseIdentifier: String = "cell") -> DataSource {
    return DataSource(
      models: banks,
      reuseIdentifier: reuseIdentifier
    ) { (bank, cell) in
      cell.textLabel?.text = bank.name
      cell.detailTextLabel?.text = bank.number
    }
  }
}

extension DataSource where Model == SubItem {
  static func make(for items: [SubItem],
                   reuseIdentifier: String = "cell") -> DataSource {
    return DataSource(
      models: items,
      reuseIdentifier: reuseIdentifier
    ) { (item, cell) in
      let aCell = cell as! FundTableViewCell
      aCell.textLbl.text = item.name
      aCell.detailLbl.text = item.detail
    }
  }
}

extension DataSource where Model == Item {
  static func make(for items: [Item],
                   reuseIdentifier: String = "cell") -> DataSource {
    return DataSource(
      models: items,
      reuseIdentifier: reuseIdentifier
    ) { (item, cell) in
      cell.textLabel?.text = item.name
      cell.detailTextLabel?.text = item.detail
    }
  }
}

// MARK: SectionedTableViewDataSource Implementation
class SectionedTableViewDataSource: NSObject {
  private let dataSources: [UITableViewDataSource]
  var headers: [String]?
  var headerReuseIndentifier: String?
  
  init(dataSources: [UITableViewDataSource]) {
    self.dataSources = dataSources
  }
}

// MARK: SectionedTableViewDataSource Extension
extension SectionedTableViewDataSource: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return dataSources.count
  }
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    let dataSource = dataSources[section]
    return dataSource.tableView(tableView, numberOfRowsInSection: 0)
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dataSource = dataSources[indexPath.section]
    let indexPath = IndexPath(row: indexPath.row, section: 0)
    return dataSource.tableView(tableView, cellForRowAt: indexPath)
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section < headers?.count ?? 0 {
      return headers?[section]
    }
    return nil
  }
  
}
