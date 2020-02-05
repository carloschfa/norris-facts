//
//  DisplayFacts.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

typealias DisplayFactsUseCaseCompletionHandler = (_ fact: Result<Fact>) -> Void
typealias DisplayFactsBySearchCompletionHandler = (_ facts: Result<[Fact]>) -> Void
typealias DisplayCategoriesCompletionHandler = (_ categories: Result<[String]>) -> Void
typealias DisplayFactsByCategoryCompletionHandler = (_ facts: Result<Fact>) -> Void

protocol DisplayFactsUseCase {
  func displayRandom(completionHandler: @escaping DisplayFactsUseCaseCompletionHandler)
  func displayBySearch(with query: String, completionHandler: @escaping DisplayFactsBySearchCompletionHandler)
  func displayCategories(completionHandler: @escaping DisplayCategoriesCompletionHandler)
  func displayByCategory(with category: String, completionHandler: @escaping DisplayFactsByCategoryCompletionHandler)
}

class DisplayFactsUseCaseImplementation: DisplayFactsUseCase {
  let factsGateway: FactsGateway

  init(factsGateway: FactsGateway) {
    self.factsGateway = factsGateway
  }

  func displayRandom(completionHandler: @escaping DisplayFactsUseCaseCompletionHandler) {
    self.factsGateway.fetchRandom { (result) in
      completionHandler(result)
    }
  }

  func displayBySearch(with query: String, completionHandler: @escaping DisplayFactsBySearchCompletionHandler) {
    self.factsGateway.fetchBySearch(with: query) { (result) in
      completionHandler(result)
    }
  }

  func displayCategories(completionHandler: @escaping DisplayCategoriesCompletionHandler) {
    self.factsGateway.fetchCategories { (result) in
      completionHandler(result)
    }
  }

  func displayByCategory(with category: String, completionHandler: @escaping DisplayFactsByCategoryCompletionHandler) {
    self.factsGateway.fetchByCategory(with: category) { (result) in
      completionHandler(result)
    }
  }

}
