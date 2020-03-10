//
//  FactsSearchConfigurator.swift
//  norris-facts
//
//  Created by Carlos Henrique Antunes on 1/28/20.
//  Copyright © 2020 Carlos Henrique Antunes. All rights reserved.
//

import Foundation

protocol FactsSearchConfigurator {
  func configure(with factsSearchViewController: FactsSearchViewController)
}

class FactsSearchConfiguratorImplementation: FactsSearchConfigurator {
  func configure(with factsSearchViewController: FactsSearchViewController) {
    let apiClient = ApiClientImplementation(urlSessionConfiguration: .default, completionHandlerQueue: .main)
    let apiFactsGateway = ApiFactsGatewayImplementation(apiClient: apiClient)

    // let displayFactsUseCase = DisplayFactsUseCaseImplementation(factsGateway: apiFactsGateway)

    let router = FactsListRouterImplementation(factsListViewController: factsListViewController)

    let presenter = FactsListPresenterImplementation(view: factsListViewController, displayFactsUseCase: displayFactsUseCase, router: router)

    factsListViewController.presenter = presenter
  }

}
