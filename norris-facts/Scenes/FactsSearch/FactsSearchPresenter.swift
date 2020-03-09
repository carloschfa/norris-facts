//
//  FactsSearchPresenter.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

protocol FactsSearchPresenter {
  var numberOfSuggestions: Int { get }
  var numberOfPastSearches:  Int { get }
  func configureCell(with cell: SuggestionCollectionViewCell, for row: Int)
  func configureCell(with cell: PastSearchTableViewCell, for row: Int)
  func viewDidLoad()
  func searchBarButtonPressed()
}

class FactsSearchPresenterImplementation: FactsSearchPresenter {
  var categories: [String] = []
  var pastSearches: [String] = []
  
  var numberOfSuggestions: Int { return categories.count }
  var numberOfPastSearches: Int { return pastSearches.count }
  
  init() {
    
  }
  
  func viewDidLoad() {
    
  }
  
  func configureCell(with cell: PastSearchTableViewCell, for row: Int) {
    
  }
  
  func configureCell(with cell: SuggestionCollectionViewCell, for row: Int) {
    
  }
  
  func searchBarButtonPressed() {
    
  }
  
}
