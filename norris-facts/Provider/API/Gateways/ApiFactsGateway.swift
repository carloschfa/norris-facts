//
//  ApiFactsGateway.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

protocol ApiFactsGateway: FactsGateway { }

class ApiFactsGatewayImplementation: ApiFactsGateway {
  let apiClient: ApiClient

  init(apiClient: ApiClient) {
    self.apiClient = apiClient
  }

  // MARK: - ApiFactsGateway

  func fetchRandom(completionHandler: @escaping FetchRandomFactEntityGatewayCompletionHandler) {
    let request = FactsRandomApiRequest()
    apiClient.execute(request: request) { (result: Result<ApiResponse<ApiFact>>) in
      switch result {
      case let .success(response):
        let fact = response.entity.fact
        apiCoreDataFactsProvider?.insert(fact: fact)
        guard let facts = apiCoreDataFactsProvider?.getFacts() else { return }
        completionHandler(.success(facts))
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }

  }

  func fetchBySearch(with query: String, completionHandler: @escaping FetchFactsEntityBySearchGatewayCompletionHandler) {
    apiCoreDataFactsProvider?.insert(search: Search(value: query, searchedAt: Date()))
    
    let request = FactsBySearchApiRequest(query: query)
    apiClient.execute(request: request) { (result: Result<ApiResponse<[ApiFact]>>) in
      switch result {
      case let .success(response):
        let facts = response.entity.map { return $0.fact }
        facts.forEach { apiCoreDataFactsProvider?.insert(fact: $0) }
        guard let localFacts = apiCoreDataFactsProvider?.getFacts(where: query) else { return }
        completionHandler(.success(localFacts))
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }
  }

  func fetchCategories(completionHandler: @escaping FetchFactsCategoriesGatewayCompletionHandler) {
    
    let request = CategoriesApiRequest()
    guard let localCategories = apiCoreDataFactsProvider?.getCategories() else { return }
    if localCategories.isEmpty {
      apiClient.execute(request: request) { (result: Result<ApiResponse<[String]>>) in
        switch result {
        case let .success(response):
          let categories = response.entity.map { return Category(value: $0) }
          categories.forEach { apiCoreDataFactsProvider?.insert(category: $0) }
          completionHandler(.success(categories))
        case let .failure(error):
          completionHandler(.failure(error))
        }
      }
    } else {
      completionHandler(.success(localCategories))
    }
  }
  
  func fetchSearches(completionHandler: @escaping FetchFactsSearchesGatewayCompletionHandler) {
    guard let searches = apiCoreDataFactsProvider?.getSearches() else { return }
    completionHandler(.success(searches))
  }

  func fetchByCategory(with category: String, completionHandler: @escaping FetchFactsEntityByCategoryGatewayCompletionHandler) {
    let request = FactByCategoryApiRequest(category: category)
    apiClient.execute(request: request) { (result: Result<ApiResponse<ApiFact>>) in
      switch result {
      case let .success(response):
        let fact = response.entity.fact
        completionHandler(.success(fact))
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }
  }
}
