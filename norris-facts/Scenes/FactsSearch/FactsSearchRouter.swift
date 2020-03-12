//
//  FactsSearchRouter.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation
import UIKit

protocol FactsSearchRouter {
  func presentList()
  func presentSearch(from viewController: UIViewController?)
  var factsSearchViewController: FactsSearchViewController? { get }
}

class FactsSearchRouterImplementation: FactsSearchRouter {

  var factsSearchViewController: FactsSearchViewController?

  init() {
    
  }

  func presentSearch(from viewController: UIViewController?) {
    let factsSearch = FactsSearchViewController()
    viewController?.navigationController?.pushViewController(factsSearch, animated: true)
  }
  
  func presentList() {
    self.factsSearchViewController?.navigationController?.popViewController(animated: true)
  }

}
