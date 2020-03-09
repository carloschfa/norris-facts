//
//  FactsListRouter.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation
import UIKit

protocol FactsListRouter {
  func presentSearch()
  func presentShare(with text: String, and url: URL?)
  var factsListViewController: FactsListTableViewController? { get }
}

class FactsListRouterImplementation: FactsListRouter {

  var factsListViewController: FactsListTableViewController?

  init(factsListViewController: FactsListTableViewController) {
    self.factsListViewController = factsListViewController
  }

  func presentSearch() {
    let factsSearch = FactsSearchViewController()
    factsListViewController?.navigationController?.pushViewController(factsSearch, animated: true)
  }

  func presentShare(with text: String, and url: URL?) {
    let items: [Any] = [text, url as Any]
    let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
    factsListViewController?.present(activityViewController, animated: true)
  }

}
