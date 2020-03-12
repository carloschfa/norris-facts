//
//  FactsSearchPresenter.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

protocol FactsSearchView: class {
  // func refreshFactsView()
  // func displayFactsRetrievalError(title: String, message: String)
  func isLoading(_ value: Bool)
}

protocol FactsSearchPresenter {
  var numberOfSuggestions: Int { get }
  var numberOfPastSearches:  Int { get }
  func configureCell(with cell: SuggestionCollectionViewCell, for row: Int)
  func configureCell(with cell: PastSearchTableViewCell, for row: Int)
  func viewDidLoad()
  func searchBarButtonPressed()
}

class FactsSearchPresenterImplementation: FactsSearchPresenter {
  fileprivate weak var view: FactsSearchView?
  fileprivate let displayFactsUseCase: DisplayFactsUseCase
  internal let router: FactsSearchRouter
  
  var categories: [Category] = []
  var searches: [Search] = []
  
  var numberOfSuggestions: Int { return categories.count }
  var numberOfPastSearches: Int { return searches.count }
  
  init(view: FactsSearchView, displayFactsUseCase: DisplayFactsUseCase, router: FactsSearchRouter) {
    self.view = view
    self.displayFactsUseCase = displayFactsUseCase
    self.router = router
    viewDidLoad()
  }
  
  func viewDidLoad() {
    self.displayFactsUseCase.displayCategories { (result) in
      switch result {
      case .success(let categories):
        self.categories = categories
        print("contagem de categories -> \(categories.count)")
      case .failure(let error):
        NSLog(error.localizedDescription)
      }
    }
    
    self.displayFactsUseCase.displaySearches { (result) in
      switch result {
      case .success(let searches):
        self.searches = searches
        print("contagem de searches -> \(searches.count)")
      case .failure(let error):
        NSLog(error.localizedDescription)
      }
    }
  }
  
  func configureCell(with cell: PastSearchTableViewCell, for row: Int) {
    
  }
  
  func configureCell(with cell: SuggestionCollectionViewCell, for row: Int) {
    
  }
  
  func searchBarButtonPressed() {
    
  }
  
}
