//
//  FactsGateway.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/27/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

typealias FetchRandomFactEntityGatewayCompletionHandler = (_ fact: Result<Fact, Error>) -> Void
typealias FetchFactsEntityBySearchGatewayCompletionHandler = (_ facts: Result<[Fact], Error>) -> Void
typealias FetchFactsCategoriesGatewayCompletionHandler = (_ categories: Result<[String], Error>) -> Void
typealias FetchFactsEntityByCategoryGatewayCompletionHandler = (_ facts: Result<[Fact], Error>) -> Void

protocol FactsGateway {
  func fetchRandom(completionHandler: @escaping FetchRandomFactEntityGatewayCompletionHandler)
  func fetchBySearch(completionHandler: @escaping FetchFactsEntityBySearchGatewayCompletionHandler)
  func fetchCategories(completionHandler: @escaping FetchFactsCategoriesGatewayCompletionHandler)
  func fetchByCategory(completionHandler: @escaping FetchFactsEntityByCategoryGatewayCompletionHandler)
}
