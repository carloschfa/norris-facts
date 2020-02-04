//
//  FactsListPresenter.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

protocol FactsListView: class {
  func refreshFactsView()
  func displayFactsRetrievalError(title: String, message: String)
  func isLoading(_ value: Bool)
}

protocol FactsListPresenter {
  var numberOfFacts: Int { get }
  var router: FactsListRouter { get }
  func configureCell(with cell: FactItemTableViewCell, forRow row: Int)
  func viewDidLoad()
  func searchButtonPressed()
}

class FactsListPresenterImplementation: FactsListPresenter {
  fileprivate weak var view: FactsListView?
  fileprivate let displayFactsUseCase: DisplayFactsUseCase
  internal let router: FactsListRouter

  var facts = [Fact]()

  var numberOfFacts: Int { return facts.count }

  init(view: FactsListView,
    displayFactsUseCase: DisplayFactsUseCase,
    router: FactsListRouter) {
    self.view = view
    self.displayFactsUseCase = displayFactsUseCase
    self.router = router
  }

  func viewDidLoad() {
    view?.isLoading(true)
    self.displayFactsUseCase.displayRandom { (result) in
      switch result {
      case let .success(fact):
        self.handleFactsReceived([fact])
        self.view?.isLoading(false)
      case let .failure(error):
        self.handleFactsError(error)
        self.view?.isLoading(false)
      }
    }
  }

  func configureCell(with cell: FactItemTableViewCell, forRow row: Int) {
    let fact = facts[row]
    cell.setupCell(with: fact.value, and: URL(string: fact.url)!)
    cell.delegate = self
  }
  
  func searchButtonPressed() {
    router.presentSearch()
  }
  
  private func handleFactsReceived(_ facts: [Fact]) {
    self.facts = facts
    view?.refreshFactsView()
  }
  
  private func handleFactsError(_ error: Error) {
    view?.displayFactsRetrievalError(title: "Error", message: error.localizedDescription)
  }

}

extension FactsListPresenterImplementation: FactItemTableViewCellDelegate {
  func shareButtonIsPressed(with text: String , and url: URL?) {
    router.presentShare(with: text, and: url)
  }
}

