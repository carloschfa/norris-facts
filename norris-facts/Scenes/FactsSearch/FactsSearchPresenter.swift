//
//  FactsSearchPresenter.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

enum ResultType {
  case searches
  case categories
}

protocol FactsSearchView: class {
  func refreshSearchView(for: ResultType)
  func displaySearchRetrievalError(title: String, message: String)
  func isLoading(_ value: Bool)
}

protocol FactsSearchPresenter {
  var numberOfSuggestions: Int { get }
  var numberOfPastSearches:  Int { get }
  func defineListPresenter(using presenter: FactsListPresenter)
  func configureCell(with cell: SuggestionCollectionViewCell, for row: Int)
  func configureCell(with cell: PastSearchTableViewCell, for row: Int)
  func viewDidLoad()
  func search(for query: String)
}

class FactsSearchPresenterImplementation: FactsSearchPresenter {
  fileprivate weak var view: FactsSearchView?
  fileprivate let displayFactsUseCase: DisplayFactsUseCase
  internal let router: FactsSearchRouter
  
  private var listPresenter: FactsListPresenter?
  
  private var categories: [Category] = []
  private var searches: [Search] = []
  
  var numberOfSuggestions: Int { return categories.count }
  var numberOfPastSearches: Int { return searches.count }
  
  init(view: FactsSearchView, displayFactsUseCase: DisplayFactsUseCase, router: FactsSearchRouter) {
    self.view = view
    self.displayFactsUseCase = displayFactsUseCase
    self.router = router
  }
  
  func defineListPresenter(using presenter: FactsListPresenter) {
    self.listPresenter = presenter
  }
  
  func viewDidLoad() {
    view?.isLoading(true)
    self.displayFactsUseCase.displayCategories { (result) in
      switch result {
      case .success(let categories):
        self.categories = categories
        self.view?.refreshSearchView(for: .categories)
        self.view?.isLoading(false)
      case .failure(let error):
        self.view?.isLoading(false)
        self.view?.displaySearchRetrievalError(title: "Error", message: error.localizedDescription)
      }
    }
    
    self.displayFactsUseCase.displaySearches { (result) in
      switch result {
      case .success(let searches):
        self.searches = searches
        self.view?.refreshSearchView(for: .searches)
      case .failure(let error):
        self.view?.isLoading(false)
        self.view?.displaySearchRetrievalError(title: "Error", message: error.localizedDescription)
      }
    }
  }
  
  func configureCell(with cell: PastSearchTableViewCell, for row: Int) {
    if !searches.isEmpty {
      let search = searches[row]
      cell.configureCell(search: search)
      cell.delegate = self
    }
  }
  
  func configureCell(with cell: SuggestionCollectionViewCell, for row: Int) {
    if !categories.isEmpty {
      let category = categories[row]
      cell.configureCell(category: category)
      cell.delegate = self
    }
  }
  
  func search(for query: String) {
    view?.isLoading(true)
    self.displayFactsUseCase.displayBySearch(with: query) { (result) in
      switch result {
      case .success(let facts):
        self.listPresenter?.reloadFacts(with: facts)
        self.view?.isLoading(false)
        self.router.presentList()
      case .failure(let error):
        self.view?.isLoading(false)
        self.view?.displaySearchRetrievalError(title: "Error", message: error.localizedDescription)
      }
    }
  }
  
}

extension FactsSearchPresenterImplementation: SuggestionCollectionViewCellDelegate {
  func suggestionItemIsPressed(with value: String) {
    search(for: value)
  }
}

extension FactsSearchPresenterImplementation: PastSearchTableViewCellDelegate {
  func searchItemIsPressed(with value: String) {
    search(for: value)
  }
}
