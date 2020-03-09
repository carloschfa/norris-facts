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
    let request = FactsBySearchApiRequest(query: query)
    apiClient.execute(request: request) { (result: Result<ApiResponse<ApiFactResponse>>) in
      switch result {
      case let .success(response):
        guard let localFacts = apiCoreDataFactsProvider?.getFacts() else { return }
        var facts = response.entity.facts.map { return $0.fact }
        facts.append(contentsOf: localFacts)
        completionHandler(.success(facts))
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }
  }

  func fetchCategories(completionHandler: @escaping FetchFactsCategoriesGatewayCompletionHandler) {
    let request = CategoriesApiRequest()
    apiClient.execute(request: request) { (result: Result<ApiResponse<[String]>>) in
      switch result {
      case let .success(response):  
        let fact = response.entity.map { return $0 }
        completionHandler(.success(fact))
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }
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
