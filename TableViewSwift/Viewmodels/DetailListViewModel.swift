//
//  DetailListViewModel.swift
//  TableViewSwift
//
//  Created by Home on 3/7/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

// MARK: Coordinator Delegate
protocol DetailListViewModelCoordinatorDelegate: class {
  func goBackToListViewControllerWithItem(item: Item)
}

// MARK: View Delegate
protocol DetailListViewModelViewDelegate: class {
  
}

// MARK: View Model Interface
protocol DetailListViewModelInterface {
  var listViewModelCoordinatorDelegate: DetailListViewModelCoordinatorDelegate? { get set } // ListCoordinator
  var listVMViewDelegate: DetailListViewModelViewDelegate? { get set }
  func detailListViewModeldidSelect(item: Item) // Action from tableview didSelectRow at indexPath
}

class DetailListViewModel: DetailListViewModelInterface {  
  var listViewModelCoordinatorDelegate: DetailListViewModelCoordinatorDelegate?
  var listVMViewDelegate: DetailListViewModelViewDelegate?
  func detailListViewModeldidSelect(item: Item) {
  // coordinator go to appropriate view
    listViewModelCoordinatorDelegate?.goBackToListViewControllerWithItem(item: item)

    print(" \(item) selected")
  }
}
