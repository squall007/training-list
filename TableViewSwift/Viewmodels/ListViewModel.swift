//
//  ListViewModel.swift
//  TableViewSwift
//
//  Created by Home on 3/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation

// MARK: View Delegate
protocol ListViewModelViewDelegate: class {
  
}
// MARK: Coordinator Delegate
protocol ListViewModelCoordinatorDelegate: class {
  func goToDetailView() // ask coordinator to push Detail view
  func presentAmountView() // ask coordinator to present overlay
}

// MARK: View Model Interface
protocol ListViewModelInterface {
  var model: [Item]? { get set } // object used to populate Tableview
  var viewDelegate: ListViewModelViewDelegate? { get set } // ListViewController
  var coordinatorDelegate: ListViewModelCoordinatorDelegate? { get set} // ListCoordinator
  func didSelect(item: SubItem) // Action from tableview didSelectRow at indexPath
}

// MARK: View Model Implementation
class ListViewModel: ListViewModelInterface {
  var model: [Item]?
  var viewDelegate: ListViewModelViewDelegate?
  var coordinatorDelegate: ListViewModelCoordinatorDelegate?
  
  func didSelect(item: SubItem) {
    print(item)    // coordinator go to appropriate view
    if item.name == "Fund" {
      coordinatorDelegate?.goToDetailView()
    } else if item.name == "To" {
      coordinatorDelegate?.presentAmountView()

    }
    print("selected")
  }
}
