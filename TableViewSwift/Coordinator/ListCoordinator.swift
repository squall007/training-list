//
//  ListCoordinator.swift
//  TableViewSwift
//
//  Created by Home on 3/6/20.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

// MARK - List coordinator interface
protocol ListCoordinatorInterface {
  var navigationController: UINavigationController { get set }
  func start() // push List VC
}

// MARK - List coordinator implementation
class ListCoordinator:ListCoordinatorInterface {
  var navigationController: UINavigationController
  var listViewController: ListViewController?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
    guard let listViewController = listViewController else { return }
    let viewModel =  ListViewModel()
    viewModel.coordinatorDelegate = self
    listViewController.viewModel = viewModel
    navigationController.pushViewController(listViewController, animated: false)
  }
}

// MARK - List coordinator ListViewModel delegate methods
extension ListCoordinator: ListViewModelCoordinatorDelegate {
  func presentAmountView() {
    let overlayVC = OverlayViewController.instantiate()
    overlayVC.modalPresentationStyle = .automatic
    navigationController.present(overlayVC, animated: false, completion: nil)
  }
  
  func goToDetailView() {
    let detailViewController = DetailListViewController.instantiate()
    let viewModel = DetailListViewModel()
    viewModel.listViewModelCoordinatorDelegate = self
    detailViewController.viewModel = viewModel
    navigationController.pushViewController(detailViewController, animated: false)
  }
}

// MARK - List coordinator DetailList delegate methods
extension ListCoordinator:DetailListViewModelCoordinatorDelegate {
  func goBackToListViewControllerWithItem(item: Item) {
    listViewController?.updateUIWithItem(itemSelected: item)
    navigationController.popViewController(animated: true)
  }
}

// MARK - Helper for Storyboard instantiation
protocol Storyboarded {
  static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
  static func instantiate() -> Self {
    // this pulls out "MyApp.MyViewController"
    let fullName = NSStringFromClass(self)
    // this splits by the dot and uses everything after, giving "MyViewController"
    let className = fullName.components(separatedBy: ".")[1]
    // load our storyboard
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    // instantiate a view controller with that identifier, and force cast as the type that was requested
    return storyboard.instantiateViewController(withIdentifier: className) as! Self
  }
}
