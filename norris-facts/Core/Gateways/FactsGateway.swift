//
//  FactsGateway.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

typealias FetchRandomFactEntityGatewayCompletionHandler = (_ fact: Result<Fact>) -> Void
typealias FetchFactsEntityBySearchGatewayCompletionHandler = (_ facts: Result<[Fact]>) -> Void
typealias FetchFactsCategoriesGatewayCompletionHandler = (_ categories: Result<[String]>) -> Void
typealias FetchFactsEntityByCategoryGatewayCompletionHandler = (_ facts: Result<Fact>) -> Void

protocol FactsGateway {
  func fetchRandom(completionHandler: @escaping FetchRandomFactEntityGatewayCompletionHandler)
  func fetchBySearch(with query: String, completionHandler: @escaping FetchFactsEntityBySearchGatewayCompletionHandler)
  func fetchCategories(completionHandler: @escaping FetchFactsCategoriesGatewayCompletionHandler)
  func fetchByCategory(with category: String, completionHandler: @escaping FetchFactsEntityByCategoryGatewayCompletionHandler)
}
